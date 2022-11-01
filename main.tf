terraform {
required_providers {
google = {
source = "registry.terraform.io/hashicorp/google"
}
}
backend "local" {
path = "state/terraform.tfstate"
}
}

provider "google" {
project = "qwiklabs-gcp-00-35dc4c022bc7"
region = "EU"
}
resource "google_service_account" "service-account" {
account_id = "testterraformvm1network1"
display_name = "TEST TERRAFORM WITH VM1 & NETWORK1"
description = "Service account the compute instance to be used"
disabled = "false"
}

resource "google_compute_instance" "testvm-network" {
name = "testvm-network"
zone = "europe-north1-a"
machine_type = "n2d-standard-8"
allow_stopping_for_update = "true"

boot_disk {
auto_delete = "false"
device_name = "vm-disk"
mode = "READ_WRITE"
initialize_params {
size = "10"
type = "pd-balanced"
image = "ubuntu-os-cloud/ubuntu-2004-lts"
}
}
metadata_startup_script = "echo hi > /test.txt"
network_interface {
network = "testvm-network1"
subnetwork = "testvm-subnet1"
nic_type = "GVNIC"
stack_type = "IPV4_ONLY"
access_config {
network_tier = "STANDARD"
}
}
service_account {
email = google_service_account.service-account.email
scopes = [ "cloud-platform" ]
}
scheduling {
on_host_maintenance = "TERMINATE"

}
shielded_instance_config {
enable_secure_boot = "true"
enable_vtpm = "true"
}
confidential_instance_config {
enable_confidential_compute = "true"
}
}

resource "google_storage_bucket" "storage_bucket" {
name = "qwiklabs-gcp-00-35dc4c022bc7"
location = "US"
force_destroy = "true"
uniform_bucket_level_access = "true"
storage_class = "STANDARD"
depends_on = ["google_compute_instance.testvm-network"]

  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "ARCHIVE"
    }
    condition {
age = "370"

    }
  }
}
resource "google_compute_network" "custom-network" {
name = "testvm-network1"
auto_create_subnetworks = false
mtu = 1500
routing_mode = "GLOBAL"
delete_default_routes_on_create = "false"
}

resource "google_compute_subnetwork" "subnetwork-with-private-secondary-iprange" {
name = "testvm-subnet1"
ip_cidr_range = "10.2.0.0/16"
region = "europe-north1"
network = "testvm-network1"

secondary_ip_range {
range_name = "tf-test-secondary-range-update1"
ip_cidr_range = "192.168.10.0/24"
}
}
resource "google_compute_subnetwork" "subnetwork-with-second-region" {
name = "testvm-subnet2"
ip_cidr_range = "10.0.0.0/22"
region = "europe-central2"
network = "testvm-network1"
private_ip_google_access = "true"
stack_type = "IPV4_ONLY"
}
