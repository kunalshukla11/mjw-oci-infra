variable "region" {
  description = "region where you have OCI tenancy"
  type        = string
  default     = "uk-london-1"
}
variable "profile" {
  description = "profile name"
  type        = string

}
variable "tags" {
  description = "Freeform tags."
  type        = map(any)
}
variable "compartment_name" {
  description = "The name of the compartment."
  type        = string
  default     = "mjw_cmpt_dev"
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
variable "vm_image_ocid_ampere" {
  description = "VM Image OCID"
  type        = string
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
