data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}
# data "cloudinit_config" "mjw_cloud_init" {
#   for_each = local.instance
#
#   part {
#     content = yamlencode(each.value.user_data)
#
#     content_type = "text/cloud-config"
#   }
# }

data "oci_core_boot_volumes" "mjw_boot_volumes" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain_number].name
  compartment_id      = var.compartment_ocid
}

#mjw db instances

data "oci_core_instance_devices" "mjw_vm_db_devices" {
  instance_id = oci_core_instance.mjw_vm_db[0].id
}
