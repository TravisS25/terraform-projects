# resource "lxd_profile" "base_profile" {
#     name = "base-profile"

#     device {
#         name = "eth0"
#         type = "nic"

#         dynamic "properties" {
#             for_each = var.droplets
#             iterator = droplet
#             content {
#                 nictype = "bridged"
#                 network  = "${lxd_network.dev.name}"
#                 ipv4.address = droplet.ip
#             }
#         }
#     }

#     device {
#         name = "root"
#         type = "disk"

#         properties = {
#             pool = "default"
#             path = "/"
#         }
#     }
# }

# resource "lxd_profile" "storage_profile" {
#     name = "storage-profile"

#     dynamic "device" {
#         count = 4
#         content {
#             name = "minio${count.index+1}"
#             type = "disk"

#             properties = {
#                 pool = "default"
#                 path = "/"
#             }
#         }
#     }
# }