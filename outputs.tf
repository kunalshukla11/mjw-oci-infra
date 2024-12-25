# Output the "list" of all availability domains.

output "compartment-name" {
  value = oci_identity_compartment.mjw_cmpt.name
}

