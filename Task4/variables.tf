variable "project_name" {
  description = "Prefix for all resources."
  type        = string
}

variable "cloud_id" {
  description = "Yandex Cloud ID."
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud folder ID."
  type        = string
}

variable "zone" {
  description = "Default availability zone."
  type        = string
}

variable "existing_network_id" {
  description = "Existing VPC network ID used in this educational environment."
  type        = string
}

variable "existing_subnet_id" {
  description = "Existing subnet ID where VMs are attached."
  type        = string
}

variable "service_account_key_file" {
  description = "Path to Authorized key JSON for service account authentication."
  type        = string
}

variable "public_ssh_key_path" {
  description = "Path to public SSH key for VM access."
  type        = string
}

variable "ssh_user" {
  description = "Linux user for SSH metadata."
  type        = string
}

variable "admin_cidr" {
  description = "CIDR range allowed to SSH to bastion host."
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet."
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet."
  type        = string
}

variable "boot_disk_size_gb" {
  description = "Boot disk size for all VMs."
  type        = number
}

variable "bastion_cores" {
  description = "vCPU count for bastion VM."
  type        = number
}

variable "bastion_memory_gb" {
  description = "RAM size for bastion VM."
  type        = number
}

variable "lakehouse_cores" {
  description = "vCPU count for lakehouse VM."
  type        = number
}

variable "lakehouse_memory_gb" {
  description = "RAM size for lakehouse VM."
  type        = number
}

variable "lakehouse_disk_size_gb" {
  description = "Data disk size for lakehouse VM."
  type        = number
}

variable "fintech_cores" {
  description = "vCPU count for fintech VM."
  type        = number
}

variable "fintech_memory_gb" {
  description = "RAM size for fintech VM."
  type        = number
}

variable "fintech_disk_size_gb" {
  description = "Data disk size for fintech VM."
  type        = number
}

variable "ai_cores" {
  description = "vCPU count for AI VM."
  type        = number
}

variable "ai_memory_gb" {
  description = "RAM size for AI VM."
  type        = number
}

variable "ai_disk_size_gb" {
  description = "Data disk size for AI VM."
  type        = number
}
