terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.12.0"
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
  # Путь к файлу ключа сервисного аккаунта
  service_account_key_file = "/home/user/.ssh/authorized_key.json"
}