###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}


variable "image_name" {
  type = string
  default = "ubuntu-2004-lts"
}

variable "vpc_hdd" {
  type        = number
  default     = 5
  description = "VPC HDD size"
}

variable "main" {
  type    = map(string)
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
}

variable "replica" {
  type    = map(string)
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
}

variable "vm_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Types of physical processors"
}
