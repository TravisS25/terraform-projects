provider "lxd" {}

resource "lxd_network" "network" {
    name = "playground"

    config = {
        "ipv4.address" = "192.168.4.1/24"
        "ipv4.nat"     = true
    }
}

resource "lxd_storage_pool" "pool" {
    name = "playground"
    driver = "lvm"
    config = {
        source                      = "/var/snap/lxd/common/lxd/disks/playground.img"
        size                        = "65GiB"
        "volume.block.filesystem"   = "ext4"
    }
}

resource "lxd_container" "droplets" {
    count = 1

    name      = "host${count.index+1}"
    image     = "ubuntu_22.04" // images:4574619138f7
    ephemeral = false
    start_container = true

    config = {
        "boot.autostart"                        = true
        "security.nesting"                      = true
        "security.syscalls.intercept.mknod"     = true
        "security.syscalls.intercept.setxattr"  = true
        "user.user-data"                    = <<-EOT
            #cloud-config

            ${yamlencode(local.cloud_init.user_data)}
        EOT
        "user.network-config"               = <<-EOT
            ${yamlencode(local.cloud_init.network_config)}
        EOT
    }

    limits = {
        cpu     = 1
        memory  = "2048MiB"
    }

    device {
        name = "eth0"
        type = "nic"

        properties = {
            nictype         = "bridged"
            parent          = "${lxd_network.network.name}"
            "ipv4.address"  = "192.168.4.${count.index+2}"
        }
    }

    device {
        type = "disk"
        name = "root"

        properties = {
            path = "/"
            pool = "${lxd_storage_pool.pool.name}"
            size = "15GiB"
        }
    }
}