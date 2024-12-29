
resource "oci_core_volume_backup_policy" "mjw_volume_backup_policy" {
  compartment_id = var.compartment_ocid
  display_name   = format("%sVolumeBackupPolicy", replace(title(var.app_name), "/\\s/", ""))
  freeform_tags  = var.tags

  schedules {
    backup_type       = "INCREMENTAL"
    day_of_month      = 1
    day_of_week       = "FRIDAY"
    hour_of_day       = 3
    month             = "JANUARY"
    offset_seconds    = 0
    offset_type       = "STRUCTURED"
    period            = "ONE_WEEK"
    retention_seconds = 3024000 # 5 week
    time_zone         = "REGIONAL_DATA_CENTER_TIME"
  }
}

# TODO -- Uncomment after understading usage of backup policy
# resource "oci_core_volume_backup_policy_assignment" "mjw_boot_volume_backup_policy_assignment" {
#   for_each  = var.instances
#   asset_id  = each.value
#   policy_id = oci_core_volume_backup_policy.mjw_volume_backup_policy.id
#
#   depends_on = [
#     oci_core_instance.mjw_vm_db
#   ]
# }
