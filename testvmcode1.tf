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

provider "google" {
  region = "US"
}


resource "google_compute_instance" "testvm1" {
  name                      = "test-vm1"
  zone                      = "us-central1-c"
  machine_type              = "c2d-standard-4"
  allow_stopping_for_update = "true"
  boot_disk {
    auto_delete = "false"
    mode        = "READ_WRITE"
    initialize_params {
      size  = "50"
      type  = "pd-balanced"
      image = "windows-sql-cloud/sql-web-2019-win-2022"
    }
  }

  network_interface {
    network  = "default"
    nic_type = "GVNIC"
    access_config {
      network_tier = "STANDARD"
    }
  }
  metadata_startup_script = "echo hi > /test.txt"

 
}

resource "google_storage_bucket" "test-bucket" {
  name                        = "qwiklabs-gcp-02-8093e93eeb47"
  location                    = "ASIA-EAST1"
  force_destroy               = "true"
  uniform_bucket_level_access = "true"
  storage_class               = "STANDARD"
  depends_on                  = ["google_compute_instance.testvm1"]

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
