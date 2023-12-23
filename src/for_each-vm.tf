data "yandex_compute_image" "ubuntu" {
  family = var.image_name
}

resource "yandex_compute_instance" "example_each" {
  depends_on = [ yandex_compute_instance.example ]
  platform_id = var.vm_platform_id
  for_each = { for vm in local.vm_inst: "${vm.name}" => vm }
  name = each.key
  resources {
        cores           = each.value.cpu
        memory          = each.value.ram
        core_fraction   = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type = "network-hdd"
      size = var.vpc_hdd
    }   
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/ed25519my.pub")}"
  }

  scheduling_policy { preemptible = true }

  network_interface { 
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [
      yandex_vpc_security_group.example.id
    ]
  }
}

