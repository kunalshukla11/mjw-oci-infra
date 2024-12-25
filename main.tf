terraform {
  required_version = ">= 1.1.0"

  backend "local" {
    path = "terraform.tfstate"
  }

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.0.0"
    }
  }
}

provider "oci" {
  auth                = "SecurityToken"
  config_file_profile = var.profile
  region              = var.region
}
