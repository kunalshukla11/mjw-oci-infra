terraform {
  required_version = ">= 1.1.0"

  backend "s3" {
    bucket                      = "terraform-states"
    region                      = ""
    key                         = ""
    access_key                  = ""
    secret_key                  = ""
    profile                     = ""
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
    skip_s3_checksum            = true
    skip_metadata_api_check     = true
    endpoints = {
      s3 = ""
    }
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
