# Output the "list" of all availability domains.
output "all-availability-domains-in-your-tenancy" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}

#Db instance information
output "public-ip-mjw-vm-db" {
  value = oci_core_instance.mjw_vm_db[0].public_ip
}

output "private-ip-mjw-vm-db" {
  value = oci_core_instance.mjw_vm_db[0].private_ip
}

output "instance_devices_mjw_vm_db" {
  value = data.oci_core_instance_devices.mjw_vm_db_devices.devices
}

output "boot_volume_id_mjw_vm_db" {
  value = oci_core_instance.mjw_vm_db[0].boot_volume_id
}

