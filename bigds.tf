terraform {
required_providers {
google = {
source = "registry.terraform.io/hashicorp/google"
  version = "<=4.41.0"
  configuration_aliases = [ google.src, google.dst ]
  credentials = "PATH OF SERVICE ACCOUNT KEY FILE"
}
}
 backend "gcs" {
 backend = "PUT THE NAME FOR A BUCKET HERE"
   prefix = "terraform/terraform.tfstate"
 } 
}

resource "google_bigquery_dataset" "bigdssrc" {
dataset_id = "bigquerysrc"
  friendly_name = "srcone"
  description = "Its the source big query dataset"
  location = "US"
  default_table_expiration_ms = 14400000


lables = {
  env = "default"
}

access {
role = "EDITOR"
  user_by_email = google_service_account.bqeditor.email
}
access {
role = "READER"
  group_by_email = ""
}
 access {
    dataset {
      dataset {
        project_id = google_bigquery_dataset.bigdssrc.project
        dataset_id = google_bigquery_dataset.bigdssrc.dataset_id
      }
      target_types = ["VIEWS"]
    }
  }
   default_encryption_configuration {
    kms_key_name = google_kms_crypto_key.crypto_key.id
  }
}
resource "google_kms_crypto_key" "crypto_key" {
  name     = "example-key"
  key_ring = google_kms_key_ring.key_ring.id
}
resource "google_kms_key_ring" "key_ring" {
  name     = "example-keyring"
  location = "us"
}
resource "google_service_account" "bqeditor" {
  account_id = "bqeditor"
}

