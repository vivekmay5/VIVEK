terraform {
required_providers {
google = {
source = "registry.terraform.io/hashicorp/google"
version = "4.41.0"
}
}
backend "gcs" {
bucket = "bucketname"
prefix = "terraformvivekstate/state/terraform.tfstate"
}
}
provider "google" {
project_id = var.projectid
region = "us-central1"
}
resource "google_compute_instance" "test-vm" {
name = var.name
machine_type = var.machine_type
zone = "us-central1-a"

boot_disk {
auto_delete = "false"
mode = "READ_WRITE"
initialize_params {
size = "10"
type = "pd-ssd"
image = var.image
}
}
network_interface {
network = "default"
nic_type = "GVNIC"
access_config {
network_tier = "STANDARD"

}
}
shielded_instance_config {
enable_secure_boot = "true"
enable_vtpm = "true" 
}

}
resource "google_storage_bucket" "vivek-bucket" {
name = var.storage-name
location = "US"
force_destroy = "true"
storage_class = "STANDARD"
depends_on = [ google_compute_instance.test-vm ]
lifecycle_rule {
action {
type = "SetStorageClass"
storage_class = "ARCHIVE"
}
condition {
age = "90"
}
}
}


