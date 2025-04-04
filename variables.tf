variable "region" {
  description = "region where you have OCI tenancy"
  type        = string
  default     = "uk-london-1"
}
variable "availability_domain_number" {
  description = "availability domain number"
  type        = number
  default     = 1
}
variable "profile" {
  description = "profile name"
  type        = string

}
variable "tags" {
  description = "Freeform tags."
  type        = map(any)
}
variable "tenancy_ocid" {
  description = "The OCID of the tenancy."
  type        = string
}

variable "compartment_ocid" {
  description = "The OCID of the compartment."
  type        = string
}

variable "app_name" {
  description = "The name of the application."
  type        = string
  default     = "mjw"
}
variable "vm_db_memory" {
  description = "VM DB Memory"
  default     = 6
  type        = number
}
variable "vm_db_ocpus" {
  description = "VM DB OCPUS"
  default     = 1
  type        = number
}
variable "vm_app_memory" {
  description = "VM APP Memory"
  default     = 18
  type        = number
}
variable "vm_app_ocpus" {
  description = "VM APP OCPUS"
  default     = 3
  type        = number
}
variable "db_volume_size" {
  description = "DB Volume Size"
  default     = 50
  type        = number
}
variable "app_volume_size" {
  description = "APP Volume Size"
  default     = 50
  type        = number
}
variable "ssh_public_key" {
  description = "SSH Public Key"
  type        = string
}
variable "instance_source_type" {
  default     = "image"
  description = "The source type for the instance."
  type        = string
}
variable "vm_boot_volume_size" {
  description = "VM Boot Volume Size"
  default     = 50
  type        = number

}
variable "instances" {
  type = map(string)
  default = {
    mjw_vm_db = "oci_core_instance.mjw_vm_db.boot_volume_id"
    # mjw_vm_app = "oci_core_instance.mjw_vm_app.boot_volume_id"
  }
}

variable "budget_alert_message" {
  type    = string
  default = "Budget Alert"
}




variable "instance_image_ocid" {
  type = map(string)

  # https://docs.oracle.com/en-us/iaas/images/ubuntu-2404/canonical-ubuntu-24-04-minimal-aarch64-2024-10-08-0.htm
  #Canonical-Ubuntu-24.04-Minimal-aarch64-2024.10.08-0
  default = {
    ap-hyderabad-1 = "ocid1.image.oc1.ap-hyderabad-1.aaaaaaaav2hw27anzikymein2qlui36oskhql4nk7uvg6ys2oy3isek45ncq"
    ap-mumbai-1    = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaapj3j2y7ce7hx7mi5svv55xk56vt5gxv6m52fan53bjh3ylucuwiq"
    uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaa4z7qr5ccidp4dowvqrb65v4qnrmzmx346q7gkvsbw6vfwxh6bkfq"
  }
}


# Resources toggle 
variable "db_instance_enabled" {
  type        = bool
  default     = true
  description = "Enable DB Instance"
}
variable "app_instance_enabled" {
  type        = bool
  default     = true
  description = "Enable APP Instance"
}
variable "db_volume_enabled" {
  type        = bool
  default     = true
  description = "Enable DB Volume"
}
variable "app_volume_enabled" {
  type        = bool
  default     = true
  description = "Enable APP Volume"
}


# Secret values used for OCI services
variable "postgres_password" {
  type        = string
  description = "Postgres Password"
  sensitive   = true
}
variable "postgres_user" {
  type        = string
  description = "Postgres User"
  sensitive   = true
}

variable "mjw_service_url" {
  type        = string
  description = "MJW Service URL"
  sensitive   = true
}
variable "mjw_db_host" {
  type        = string
  description = "MJW DB Host"
  sensitive   = true

}
