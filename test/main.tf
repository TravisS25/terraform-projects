provider "lxd" {}


resource "lxd_network" "new_default" {
    name = "new_default"

    config = {
        "ipv4.address" = "192.168.3.1/24"
        "ipv4.nat"     = "true"
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
            "ipv4.address" = "192.168.3.3"
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
    name      = "test1"
    image     = "${local.default_image_name}"
    ephemeral = false
    profiles  = ["${lxd_profile.profile1.name}"]
}