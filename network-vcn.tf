
resource "oci_core_vcn" "mjw_vcn" {

  display_name   = format("%sVCN", replace(title(var.app_name), "/\\s/", ""))
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_ocid
  dns_label      = format("%svcn", lower(replace(var.app_name, "/\\s/", "")))
  freeform_tags  = var.tags
}

