project_name = "health-data-platform"

cloud_id  = "b1gb35sc2rkc67ik49h1"
folder_id = "b1g8j42m7jph8j4iiaqo"
zone      = "ru-central1-a"
existing_network_id = "enpv4603le142canglek"
existing_subnet_id  = "e9b4j2ehg8hgjbfdpml0"
service_account_key_file = "authorized_key.json"

public_ssh_key_path      = "ssh-key-1776343620368.pub"
ssh_user                 = "ubuntu"

admin_cidr          = "0.0.0.0/0"
public_subnet_cidr  = "10.10.10.0/24"
private_subnet_cidr = "10.10.20.0/24"

boot_disk_size_gb = 10

bastion_cores     = 2
bastion_memory_gb = 2

lakehouse_cores        = 2
lakehouse_memory_gb    = 4
lakehouse_disk_size_gb = 20

fintech_cores        = 2
fintech_memory_gb    = 4
fintech_disk_size_gb = 20

ai_cores        = 2
ai_memory_gb    = 4
ai_disk_size_gb = 20
