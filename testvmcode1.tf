terraform {
  required_providers {
    google = {
      source  = "registry.terraform.io/hashicorp/google"
      version = "4.41.0"
    }
  }
  backend "local" {

    path = "terraform/state/terraform.tfstate"
  }
}

resource "google_compute_instance" "testvm1" {
  name                      = "test-vm1"
  zone                      = "us-east1-d"
  machine_type              = "f1-micro"
  allow_stopping_for_update = "false"
  boot_disk {
    auto_delete = "false"
    mode        = "READ_WRITE"
    initialize_params {
      size  = "10"
      type  = "pd-balanced"
      image = "debian-11-bullseye-v20221102"
    }
  }

  network_interface {
    network  = "default"
    nic_type = "GVNIC"
    access_config {
      network_tier = "STANDARD"
    }
  }
  
}

resource "google_storage_bucket" "test-bucket" {
  name                        = "qwiklabs-gcp-01-62d27b6d42f6"
  location                    = "US"
  force_destroy               = "true"
  uniform_bucket_level_access = "true"
  storage_class               = "STANDARD"
  

  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "COLDLINE"
    }
    condition {
age = "91"

    }
  }
}
