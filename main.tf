terraform {
required_providers {
google = {
source = "registry.terraform.io/hashicorp/google"
  version = "4.41.0"
         }
}
  backend "local" {
  path = "terraform/terraform.tfvars"
  }
}
provider "google" {
project = "#PLEASE DO MENMTION THE PROPJECT ID ALWAYS HERE"
  region = "US"
  credentials = "${var.gcp_credentials} #---->PLS provide credential thing like service account 
}
resource "google_compute_instance" "instance-vm" {
name = "vivek-vm1"
machine_type = ""
}



