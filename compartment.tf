resource "oci_identity_compartment" "mjw_cmpt" {
  compartment_id = var.tenancy_ocid
  description    = "Compartment for mjw resources"
  name           = var.compartment_name
  enable_delete  = true
  freeform_tags  = merge(var.tags, { type = "oci_identity_compartment" })
}
