resource "oci_core_volume" "mjw_vm_db_core_volume" {
  count                = var.db_volume_enabled ? 1 : 0
  compartment_id       = var.compartment_ocid
  availability_domain  = data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain_number].name
  display_name         = format("%sDbCoreVolume", replace(title(var.app_name), "/\\s/", ""))
  freeform_tags        = var.tags
  size_in_gbs          = var.db_volume_size
  is_auto_tune_enabled = true
}

# TODO-- Uncomment after understading usage of backup policy
# resource "oci_core_volume_backup_policy_assignment" "mjwDb_core_volume_backup_policy_assignment" {
#   asset_id  = oci_core_volume.mjw_vm_db_core_volume.id
#   policy_id = oci_core_volume_backup_policy.mjw_volume_backup_policy.id
#
#   depends_on = [
#     oci_core_instance.mjw_vm_db
#   ]
# }

resource "oci_core_volume_attachment" "mjw_vm_db_volume_attachment" {
  attachment_type                     = "paravirtualized"
  instance_id                         = oci_core_instance.mjw_vm_db[0].id
  volume_id                           = oci_core_volume.mjw_vm_db_core_volume[0].id
  device                              = "/dev/oracleoci/oraclevdb"
  display_name                        = format("%sDbCoreVolumeAttachment", replace(title(var.app_name), "/\\s/", ""))
  is_pv_encryption_in_transit_enabled = true
  is_read_only                        = false
}
