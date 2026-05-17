### outputs for web VM

output "vm_web_info" {
  description = "Information about web VM"
  value = {
    instance_name = yandex_compute_instance.platform.name
    external_ip   = yandex_compute_instance.platform.network_interface[0].nat_ip_address
    fqdn          = yandex_compute_instance.platform.fqdn
  }
}

### outputs for db VM

output "vm_db_info" {
  description = "Information about DB VM"
  value = {
    instance_name = yandex_compute_instance.platform_db.name
    external_ip   = yandex_compute_instance.platform_db.network_interface[0].nat_ip_address
    fqdn          = yandex_compute_instance.platform_db.fqdn
  }
}