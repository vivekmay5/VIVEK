provider "google" {
project = ""
  region = "asia-south1"
  zone = "asian-south1-a"
  credentials = ""
}

provider "google" {
  alias = "google1"
project = ""
  region = "us-east1"
  zone = "us-east1-b"
}

provider "google" {
alias = "google2"
  project ""
  region = "us-east1"
}

module "testvmcode1" {
source = "./testvmcode1"
  
  providers = {
  google.loc1 = google.google1
  google.loc2 = google.google2
  }
  }
  
  module "testvmcode1" {
  source = "./testvmcode1"
         providers = {
         google.loc1 = google.google1 
         }
  }
