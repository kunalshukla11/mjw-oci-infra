# Output the "list" of all availability domains.
output "all-availability-domains-in-your-tenancy" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}


output "public-ip-mjw-vm-db" {
  value = oci_core_instance.mjw_vm_db.public_ip
}
