output "network_id" {
  description = "VPC network ID."
  value       = var.existing_network_id
}

output "public_subnet_id" {
  description = "Public subnet ID."
  value       = var.existing_subnet_id
}

output "private_subnet_id" {
  description = "Private subnet ID."
  value       = var.existing_subnet_id
}

output "bastion_public_ip" {
  description = "Public IP of bastion host."
  value       = yandex_compute_instance.bastion.network_interface[0].nat_ip_address
}

output "lakehouse_internal_ip" {
  description = "Internal IP of lakehouse VM."
  value       = yandex_compute_instance.lakehouse.network_interface[0].ip_address
}

output "fintech_internal_ip" {
  description = "Internal IP of fintech VM."
  value       = yandex_compute_instance.fintech_service.network_interface[0].ip_address
}

output "ai_internal_ip" {
  description = "Internal IP of AI VM."
  value       = yandex_compute_instance.ai_service.network_interface[0].ip_address
}

output "attached_data_disks" {
  description = "Data disk IDs for workload VMs."
  value = {
    lakehouse = yandex_compute_disk.lakehouse_data.id
    fintech   = yandex_compute_disk.fintech_data.id
    ai        = yandex_compute_disk.ai_data.id
  }
}
