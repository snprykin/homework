terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.130.0"
    }
  }
  required_version = ">= 1.0"
}

provider "yandex" {
  zone                     = "ru-central1-a"
  folder_id                = "b1g9p43hspfbf3eqck03"
  service_account_key_file = "/home/user/.authorized_key.json"
}

# ============================================
# 1. Сервисный аккаунт для Instance Group
# ============================================

resource "yandex_iam_service_account" "ig-sa" {
  name        = "ig-sa"
  description = "Service account for Instance Group"
}

resource "yandex_resourcemanager_folder_iam_member" "ig-sa-editor" {
  folder_id = "b1g9p43hspfbf3eqck03"
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
}

# ============================================
# 2. VPC и подсеть
# ============================================

resource "yandex_vpc_network" "network" {
  name = "compute-lb-network"
}

resource "yandex_vpc_subnet" "public" {
  name           = "public-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.10.0.0/24"]
}

# ============================================
# 3. Security Group
# ============================================

resource "yandex_vpc_security_group" "sg" {
  name       = "compute-lb-sg"
  network_id = yandex_vpc_network.network.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "http"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  # Healthcheck от NLB — идёт с диапазонов Yandex Cloud
  ingress {
    protocol       = "TCP"
    description    = "nlb-healthchecks"
    v4_cidr_blocks = ["198.18.235.0/24", "198.18.248.0/24"]
    port           = 80
  }
}

# ============================================
# 4. Object Storage — бакет и картинка
# ============================================

resource "yandex_storage_bucket" "bucket" {
  bucket    = "snprykin-compute-lb-2026"
  folder_id = "b1g9p43hspfbf3eqck03"

  website {
    index_document = "index.html"
  }
}

resource "yandex_storage_object" "picture" {
  bucket       = yandex_storage_bucket.bucket.bucket
  key          = "picture.jpg"
  source       = "picture.jpg"
  content_type = "image/jpeg"
  acl          = "public-read"
  depends_on   = [yandex_storage_bucket.bucket]
}

# ============================================
# 5. Instance Group с LAMP
# ============================================

resource "yandex_compute_instance_group" "ig-lamp" {
  name               = "lamp-ig"
  folder_id          = "b1g9p43hspfbf3eqck03"
  service_account_id = yandex_iam_service_account.ig-sa.id

  instance_template {
    platform_id = "standard-v3"

    resources {
      cores  = 2
      memory = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
        size     = 10
        type     = "network-hdd"
      }
    }

    network_interface {
      network_id         = yandex_vpc_network.network.id
      subnet_ids         = [yandex_vpc_subnet.public.id]
      nat                = true
      security_group_ids = [yandex_vpc_security_group.sg.id]
    }

    metadata = {
      user-data = <<EOF
#cloud-config
users:
  - name: user
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh_authorized_keys:
      - ${file("/home/user/.ssh/id_ed25519.pub")}

write_files:
  - path: /var/www/html/index.html
    permissions: '0644'
    content: |
      <!DOCTYPE html>
      <html>
      <head>
       <meta charset="UTF-8">
       <title>LAMP Instance Group</title>
      </head>
      <body>
        <h1>Hello from Yandex Cloud LAMP!</h1>
        <p>Студент: Прыкин Сергей</p>
        <p>Дата: Сентябрь 2026</p>
        <img src="https://${yandex_storage_bucket.bucket.bucket}.website.yandexcloud.net/picture.jpg" alt="Picture" width="600">
      </body>
      </html>

runcmd:
  - systemctl restart apache2
EOF
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 1
    max_creating    = 1
    max_expansion   = 1
    max_deleting    = 1
  }

  health_check {
    interval            = 30
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
    http_options {
      port = 80
      path = "/"
    }
  }

  load_balancer {
    target_group_name = "lamp-tg"
  }
}

# ============================================
# 6. Сетевой балансировщик
# ============================================

resource "yandex_lb_network_load_balancer" "nlb" {
  name = "lamp-nlb"

  listener {
    name        = "http"
    port        = 80
    target_port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.ig-lamp.load_balancer[0].target_group_id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
