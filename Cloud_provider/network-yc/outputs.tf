output "nat_instance_public_ip" {
  value       = yandex_compute_instance.nat-instance.network_interface[0].nat_ip_address
  description = "Публичный IP NAT-инстанса"
}

output "public_vm_public_ip" {
  value       = yandex_compute_instance.public-vm.network_interface[0].nat_ip_address
  description = "Публичный IP public-vm"
}

output "public_vm_internal_ip" {
  value       = yandex_compute_instance.public-vm.network_interface[0].ip_address
  description = "Внутренний IP public-vm"
}

output "private_vm_internal_ip" {
  value       = yandex_compute_instance.private-vm.network_interface[0].ip_address
  description = "Внутренний IP private-vm"
}
