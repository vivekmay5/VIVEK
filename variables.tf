variable "name" {
type = string
description = "Its the name of the vm getting created"
}
variable "machine_type" {
type = string
description = "Type of the CPU for the virtual machine as per workload need"
}
variable "image" {
type = string
description = "type of disk image for the booting OS of VM"
}
variable "storage-name" {
type = string
description = "name of the storage bucket to be used which should be globally unique to access"
}
