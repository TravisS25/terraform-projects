provider "lxd" {}

resource "lxd_network" "new_default" {
  name = "new_default"

  config = {
    "ipv4.address" = "10.150.19.1/24"
    "ipv4.nat"     = "true"
    "ipv6.address" = "fd42:474b:622d:259d::1/64"
    "ipv6.nat"     = "true"
  }
}

resource "lxd_profile" "profile1" {
  name = "profile1"

  device {
    name = "eth0"
    type = "nic"

    properties = {
      nictype = "bridged"
      parent  = "${lxd_network.new_default.name}"
    }
  }

  device {
    type = "disk"
    name = "root"

    properties = {
      pool = "default"
      path = "/"
    }
  }
}

resource "lxd_container" "test1" {
  count     = 1

  name      = "test1"
  image     = "ubuntu:e299296138c2"
  ephemeral = false
  profiles  = ["${lxd_profile.profile1.name}"]
}


