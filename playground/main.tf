provider "lxd" {}

resource "lxd_network" "network" {
    name = local.app_name
    
    config = {
        "ipv4.address" = "${local.network_octet}.1/24"
        "ipv4.nat"     = true
    }
}

resource "lxd_storage_pool" "pool" {
    name = local.app_name
    driver = "lvm"
    config = {
        source                      = "/var/snap/lxd/common/lxd/disks/${local.app_name}.img"
        size                        = "20GiB"
        "volume.block.filesystem"   = "xfs"
    }
}

resource "lxd_container" "droplets" {
    count = local.global_count

    name      = "host${count.index+1}"
    image     = "ubuntu:e299296138c2"
    ephemeral = false
    start_container = true

    config = {
        "boot.autostart"        = true
        "user.user-data"        = <<-EOT
            #cloud-config

            ${yamlencode(local.cloud_init.user_data)}
        EOT
        //"user.network-config"   = yamlencode(local.cloud_init.network_config)
    }

    limits = {
        cpu     = "1"
        memory  = "2048MiB"
    }

    device {
        name = "eth0"
        type = "nic"

        properties = {
            nictype         = "bridged"
            parent          = lxd_network.network.name
            "ipv4.address"  = "${local.network_octet}.${count.index+2}"
        }
    }

    device {
        type = "disk"
        name = "root"

        properties = {
            path    = "/"
            pool    = lxd_storage_pool.pool.name
        }
    }
}