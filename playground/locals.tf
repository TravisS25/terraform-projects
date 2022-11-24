locals {
    app_name        = "playground"
    disk_name       = "disk"
    global_count    = 4
    network_octet   = "192.168.4"
    cloud_init                  = {
        user_data       = {
            users           = [
                {
                    name            = "user"
                    primary_group   = "user"
                    groups          = "sudo"
                    sudo            = "ALL=(ALL) NOPASSWD:ALL"
                    shell           = "/bin/bash"
                }
            ]
        },
        network_config  = {
            network = {
                version     = 2
                ethernets   = {
                    eth0    = {
                        dhcp4           = true
                        dhcp4-overrides = {
                            use-dns    = false
                        }
                        nameservers     = {
                            addresses   = [
                                "192.168.4.2",
                                "8.8.8.8"
                            ]
                        }
                    }
                }
            }
        }
    }
}
