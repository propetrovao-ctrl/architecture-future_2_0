terraform {
  required_version = ">= 1.5.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.118"
    }
  }
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
  service_account_key_file = var.service_account_key_file
}

data "yandex_compute_image" "ubuntu_2204" {
  family = "ubuntu-2204-lts"
}

resource "yandex_vpc_security_group" "platform_sg" {
  name       = "${var.project_name}-sg"
  network_id = var.existing_network_id

  ingress {
    description    = "SSH access from admin network"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = [var.admin_cidr]
  }

  ingress {
    description    = "Inter-service traffic within private subnet"
    protocol       = "ANY"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = [var.private_subnet_cidr]
  }

  egress {
    description    = "Allow outbound traffic"
    protocol       = "ANY"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_compute_disk" "lakehouse_data" {
  name = "${var.project_name}-lakehouse-data"
  type = "network-hdd"
  zone = var.zone
  size = var.lakehouse_disk_size_gb
}

resource "yandex_compute_disk" "bastion_boot" {
  name     = "${var.project_name}-bastion-boot"
  type     = "network-hdd"
  zone     = var.zone
  image_id = data.yandex_compute_image.ubuntu_2204.id
  size     = var.boot_disk_size_gb
}

resource "yandex_compute_disk" "lakehouse_boot" {
  name     = "${var.project_name}-lakehouse-boot"
  type     = "network-hdd"
  zone     = var.zone
  image_id = data.yandex_compute_image.ubuntu_2204.id
  size     = var.boot_disk_size_gb
}

resource "yandex_compute_disk" "fintech_boot" {
  name     = "${var.project_name}-fintech-boot"
  type     = "network-hdd"
  zone     = var.zone
  image_id = data.yandex_compute_image.ubuntu_2204.id
  size     = var.boot_disk_size_gb
}

resource "yandex_compute_disk" "ai_boot" {
  name     = "${var.project_name}-ai-boot"
  type     = "network-hdd"
  zone     = var.zone
  image_id = data.yandex_compute_image.ubuntu_2204.id
  size     = var.boot_disk_size_gb
}

resource "yandex_compute_disk" "fintech_data" {
  name = "${var.project_name}-fintech-data"
  type = "network-hdd"
  zone = var.zone
  size = var.fintech_disk_size_gb
}

resource "yandex_compute_disk" "ai_data" {
  name = "${var.project_name}-ai-data"
  type = "network-hdd"
  zone = var.zone
  size = var.ai_disk_size_gb
}

resource "yandex_compute_instance" "bastion" {
  name = "${var.project_name}-bastion"
  zone = var.zone

  resources {
    cores         = var.bastion_cores
    memory        = var.bastion_memory_gb
    core_fraction = 100
  }

  boot_disk {
    disk_id = yandex_compute_disk.bastion_boot.id
  }

  network_interface {
    subnet_id          = var.existing_subnet_id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.platform_sg.id]
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.public_ssh_key_path)}"
  }
}

resource "yandex_compute_instance" "lakehouse" {
  name = "${var.project_name}-lakehouse"
  zone = var.zone

  resources {
    cores         = var.lakehouse_cores
    memory        = var.lakehouse_memory_gb
    core_fraction = 100
  }

  boot_disk {
    disk_id = yandex_compute_disk.lakehouse_boot.id
  }

  secondary_disk {
    disk_id = yandex_compute_disk.lakehouse_data.id
  }

  network_interface {
    subnet_id          = var.existing_subnet_id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.platform_sg.id]
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.public_ssh_key_path)}"
  }
}

resource "yandex_compute_instance" "fintech_service" {
  name = "${var.project_name}-fintech-service"
  zone = var.zone

  resources {
    cores         = var.fintech_cores
    memory        = var.fintech_memory_gb
    core_fraction = 100
  }

  boot_disk {
    disk_id = yandex_compute_disk.fintech_boot.id
  }

  secondary_disk {
    disk_id = yandex_compute_disk.fintech_data.id
  }

  network_interface {
    subnet_id          = var.existing_subnet_id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.platform_sg.id]
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.public_ssh_key_path)}"
  }
}

resource "yandex_compute_instance" "ai_service" {
  name = "${var.project_name}-ai-service"
  zone = var.zone

  resources {
    cores         = var.ai_cores
    memory        = var.ai_memory_gb
    core_fraction = 100
  }

  boot_disk {
    disk_id = yandex_compute_disk.ai_boot.id
  }

  secondary_disk {
    disk_id = yandex_compute_disk.ai_data.id
  }

  network_interface {
    subnet_id          = var.existing_subnet_id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.platform_sg.id]
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.public_ssh_key_path)}"
  }
}
