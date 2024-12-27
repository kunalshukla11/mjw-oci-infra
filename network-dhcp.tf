# Source from https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_dhcp_options

resource "oci_core_dhcp_options" "mjw_dhcp_options" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.mjw_vcn.id
  display_name   = format("%sDhcp", replace(title(var.app_name), "/\\s/", ""))
  freeform_tags  = var.tags

  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  options {
    type                = "SearchDomain"
    search_domain_names = ["mjw.oraclevcn.com"]
  }

}
