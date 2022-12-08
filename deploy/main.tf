terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.83.0"
    }
  }
}
provider "yandex" {
  token     = "y0_AgAAAAABga1xAATuwQAAAADORS9MjNZ6-eaDR7-pf8CQWjfEsBkux3g"
  cloud_id  = "b1g083uvuks4c1o8jf5l"
  folder_id = "b1gfofr9ejtjardiq3j0"
  zone      = "ru-central1-a"
}

resource "yandex_vpc_network" "network" {
  name = "swarm-network"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

module "swarm_cluster" {
  source        = "./modules/instance"
  vpc_subnet_id = yandex_vpc_subnet.subnet.id
  managers      = 1
  workers       = 2
}