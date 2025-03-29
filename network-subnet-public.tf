
resource "oci_core_subnet" "mjw_public_subnet" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.mjw_vcn.id
  cidr_block     = "10.0.0.0/24"
  freeform_tags  = var.tags


  route_table_id = oci_core_vcn.mjw_vcn.default_route_table_id
  security_list_ids = [
    oci_core_security_list.mjw_public_security_list.id
  ]

  display_name    = format("%sSubnet", replace(title(var.app_name), "/\\s/", ""))
  dhcp_options_id = oci_core_dhcp_options.mjw_dhcp_options.id
  dns_label       = format("%ssubnet", lower(replace(var.app_name, "/\\s/", "")))
}

resource "oci_core_security_list" "mjw_public_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.mjw_vcn.id
  display_name   = format("%sSecurityList", replace(title(var.app_name), "/\\s/", ""))
  freeform_tags  = var.tags

  egress_security_rules {
    stateless        = false
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
  }

  ingress_security_rules {
    stateless   = false
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    description = "SSH traffic"

    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    stateless   = false
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    description = "SSH traffic"

    tcp_options {
      min = 8080
      max = 8080
    }
  }

  ingress_security_rules {
    stateless   = false
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    description = "SSH traffic"

    tcp_options {
      min = 5432
      max = 5432
    }
  }

  ingress_security_rules {
    stateless   = false
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    description = "SSH traffic"

    tcp_options {
      min = 3000
      max = 3000
    }
  }
  ingress_security_rules {
    stateless   = false
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    description = "HTTP traffic"

    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    stateless   = false
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    description = "HTTPS traffic"

    tcp_options {
      min = 443
      max = 443
    }
  }

  ingress_security_rules {
    stateless   = false
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = "1"
    description = "ICMP Port Unreachable"

    icmp_options {
      type = 3
      code = 4
    }
  }

  ingress_security_rules {
    stateless   = false
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol    = "1"
    description = "ICMP Destination Unreachable"

    icmp_options {
      type = 3
    }
  }

  ingress_security_rules {
    stateless   = false
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol    = "1"
    description = "ICMP Echo Reply"

    icmp_options {
      type = 0
    }
  }

  ingress_security_rules {
    stateless   = false
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol    = "1"
    description = "ICMP Echo"

    icmp_options {
      type = 8
    }
  }
}

resource "oci_core_network_security_group" "mjw_network_security_group" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.mjw_vcn.id
  display_name   = format("%sNetworkSecurityGroup", replace(title(var.app_name), "/\\s/", ""))
  freeform_tags  = var.tags
}

resource "oci_core_network_security_group_security_rule" "mjw_network_security_group_list_ingress" {
  network_security_group_id = oci_core_network_security_group.mjw_network_security_group.id
  direction                 = "INGRESS"
  source                    = oci_core_network_security_group.mjw_network_security_group.id
  source_type               = "NETWORK_SECURITY_GROUP"
  protocol                  = "all"
  stateless                 = true
}

resource "oci_core_network_security_group_security_rule" "mjw_network_security_group_list_egress" {
  network_security_group_id = oci_core_network_security_group.mjw_network_security_group.id
  direction                 = "EGRESS"
  destination               = oci_core_network_security_group.mjw_network_security_group.id
  destination_type          = "NETWORK_SECURITY_GROUP"
  protocol                  = "all"
  stateless                 = true
}

resource "oci_core_internet_gateway" "mjw_internet_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = format("%sIGW", replace(title(var.app_name), "/\\s/", ""))
  vcn_id         = oci_core_vcn.mjw_vcn.id
}

resource "oci_core_default_route_table" "default_route_table" {
  manage_default_resource_id = oci_core_vcn.mjw_vcn.default_route_table_id
  display_name               = "DefaultRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.mjw_internet_gateway.id
  }
}
