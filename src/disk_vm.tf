resource "yandex_compute_disk" "vhdd_1gb" {
  name  = "netology-yandex-hdd-${count.index+1}"
  count = 3
  size  = 1
}

data "yandex_compute_image" "ubuntu_storage" {
  family = var.image_name
}
resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = var.vm_platform_id
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  dynamic "secondary_disk" {
    for_each = "${yandex_compute_disk.vhdd_1gb.*.id}"
    content {
      disk_id = yandex_compute_disk.vhdd_1gb["${secondary_disk.key}"].id
   }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface { 
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/ed25519my.pub")}"
  }
}
