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
}

variable "tenancy_ocid" {
  description = "The OCID of the tenancy."
  type        = string
}
