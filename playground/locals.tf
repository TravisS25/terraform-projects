locals {
    app_name        = "playground"
    disk_name       = "disk"
    global_count    = 2
    network_octet   = "192.168.4"
    cloud_init                  = {
        user_data       = {
            users           = [
                {
                    name                = "user"
                    primary_group       = "user"
                    groups              = "sudo"
                    sudo                = "ALL=(ALL) NOPASSWD:ALL"
                    shell               = "/bin/bash"
                    ssh_authorized_keys = [
                        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxUXvd/dpkWzdf1zNT2Oq7fFV9VVEiznUp7Rezs1Kn6ARebsLoP6TsSxbGcVOXxfXz2764q8sMHmNbQ7yqxy4AvcYbSZEIOSLVs7ioPYSUQ3jBqeVvCI/lgPacBEWSLqpKYXLntsT/GF9N2D7Z60rYhUMFY0f+oPTcYtb8w8rYLQ+o5zUE0V6j2PjLqMQjvc4i/z8GvJ5QzpeS/TTj3ZRxS7AasyOY9fb1DPgzET6tD6NOyTO5iz9LMO9uEwjieqoSbjP+u6RUhW/WVdWO1M6qAxppbiDkj9pnpfHWfMS4doeigXfU4gt7HQ7bgzG5PRGgJKCCFOnO1wkjMYgzI6a56x8B8nvSjf2taBOVfjYl71g1GbBn23S3LY1sOyvUDkTH2D5W9pr9GRIqzzeAQKppk/xL9KWahouSjjhRUxPzr24tcQwIiLZ1nmd2ZTO/AJ0LQgEzqiWZ24xMWfIBIXgkfw2MG0os8b9BT/QDMh1qcZnfpeDSyDUEAGZ802DMGzc= travis@pop-os"
                    ]
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
