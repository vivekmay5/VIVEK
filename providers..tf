provider "google" {
project = "PUT PROJECT ID HERE"
  region = "us-central1"
  zone = "us-central1-a"
}
provider "google" {
alias = "google1"
  project = "PUT PROJECT ID HERE"
  region = "us-central1"
  zone = "us-central1-b"
}
provider "google" {
alias = "google2"
  project = "PUT PROJECT ID HERE"
  region = "us-east1"
  zone = "us-east1-c"
}

module "bigquery" {
source = "./bigquery"
  providers = {
  google.src = google.google1
  google.dst = google.google2  
  }
}
