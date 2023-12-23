data "yandex_compute_image" "ubuntu-2004-lts" {
  family = var.image_name
}

resource "yandex_compute_instance" "example" {
  name        = "netology-develop-platform-web-${count.index+1}"
  platform_id = "standard-v1"
  count = 2
  resources {
    cores  = 2
    memory = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type = "network-hdd"
      size = var.vpc_hdd
    }   
  }

  metadata = {
    ssh-keys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAMJfQzj5EQrnadHCmLwb9B0qN6kJvSnFTdyWcmtHdDj ed25519-key-20231217"
    serial-port-enable = "1"
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [
      yandex_vpc_security_group.example.id
    ]
  }
  scheduling_policy {
    preemptible = true
  }
}
