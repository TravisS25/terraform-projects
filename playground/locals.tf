locals{


    cloud_init                  = {
        user_data       = {
            # manage-resolv-conf  = true
            # resolv_conf         = {
            #     nameservers: ["127.0.0.1", "8.8.8.8"]
            # }
            runcmd              = [
                ["pip3", "install", "docker"],
                ["unlink", "/etc/resolv.conf"],
                ["ln", "-sf", "/run/systemd/resolve/resolv.conf", "/etc/resolv.conf"],
                ["systemctl", "restart", "--no-block", "systemd-resolved"]
            ]
            packages            = [
                "python3-pip",
                "docker.io",
            ]
            users               = [
                {
                    name                = "user"
                    primary_group       = "user"
                    groups              = "sudo, docker"
                    sudo                = "ALL=(ALL) NOPASSWD:ALL"
                    shell               = "/bin/bash"
                    ssh_authorized_keys = [
                        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCrwzPWq1S1kXfgDUL3ylyWZrPBi9RjdgDrVWgHfOrBe+lDqpV2G68JDhDztRhgjWSkWg3zSdkAZcrW2AFZ3Uq2jovCpZqcYeWYvo1RDUKKfEb1LYdEkLrVlPCv1IY7b8UYgBoFIs9UKW1j1q/81BTy8cTWX+5g8yPy8cEiF5HxEEIOSTTzlcvVQJCGiLTuopJL5Yrgrw/e/OdOU4GcH/K8RntsShEFVkGvhZW8gfFHB4PjbgIjFdQ/kA4goIPxFgcbRK8L5rwvl2zmH1MmjA2SdFdmNMsuKWn/Xor4goSCJk0xEdIUXF4FysygI5bVj77Y1JjGANft+WQbrW4vBBIt travis@travis"
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
                                "127.0.0.1",
                                "127.0.0.53",
                                "8.8.8.8"
                            ]
                        }
                    }
                }
            }
        }
    }
}