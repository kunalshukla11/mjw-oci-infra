# Output the "list" of all availability domains.
output "all-availability-domains-in-your-tenancy" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}

#Db instance information
output "public-ip-mjw-vm-db" {
  value       = try(oci_core_instance.mjw_vm_db["db_instance"].public_ip, null)
  description = "Public IP of the database VM instance if it exists."
}

output "private-ip-mjw-vm-db" {
  value       = try(oci_core_instance.mjw_vm_db["db_instance"].private_ip, null)
  description = "Private IP of the database VM instance if it exists."
}

output "instance_devices_mjw_vm_db" {
  value = data.oci_core_instance_devices.mjw_vm_db_devices.devices
}

output "boot_volume_id_mjw_vm_db" {
  value       = try(oci_core_instance.mjw_vm_db["db_instance"].boot_volume_id, null)
  description = "Boot Volume ID of the database VM instance if it exists."
}


#App instance information
output "public-ip-mjw-vm-app" {
  value       = try(oci_core_instance.mjw_vm_app["app_instance"].public_ip, null)
  description = "Public IP of the App VM instance if it exists."
}

output "private-ip-mjw-vm-app" {
  value       = try(oci_core_instance.mjw_vm_app["app_instance"].private_ip, null)
  description = "Private IP of the App VM instance if it exists."
}


output "boot_volume_id_mjw_vm_app" {
  value       = try(oci_core_instance.mjw_vm_app["app_instance"].boot_volume_id, null)
  description = "Boot Volume ID of the App VM instance if it exists."
}


