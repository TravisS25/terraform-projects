locals {
    default_image_name = "ubuntu_20.04"

    # droplet_disks = flatten([
    #     for droplet in var.droplets : [
    #         for disk in droplet.disks : {
    #             ip = droplet.id
    #             hostname = droplet.hostname
    #             disk_name = disk.name
    #         }
    #     ]
    # ])
}
