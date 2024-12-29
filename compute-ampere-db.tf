
resource "oci_core_instance" "mjw_vm_db" {
  availability_domain                 = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id                      = var.compartment_ocid
  shape                               = "VM.Standard.A1.Flex"
  display_name                        = format("%sDbVm", replace(title(var.app_name), "/\\s/", ""))
  preserve_boot_volume                = false
  is_pv_encryption_in_transit_enabled = true
  freeform_tags                       = var.tags

  #   lifecycle {
  #     prevent_destroy = true
  #   }

  shape_config {
    memory_in_gbs = var.vm_db_memory
    ocpus         = var.vm_db_ocpus
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data           = base64encode(data.cloudinit_config.mjw_cloud_init["db_ubuntu"].rendered)
  }

  source_details {
    source_id               = var.instance_image_ocid[var.region]
    source_type             = var.instance_source_type
    boot_volume_size_in_gbs = var.vm_boot_volume_size
  }

  lifecycle {
    ignore_changes = [source_details.0.source_id]
  }

  availability_config {
    is_live_migration_preferred = true
  }

  timeouts {
    create = "60m"
  }

  create_vnic_details {
    assign_public_ip          = true
    subnet_id                 = oci_core_subnet.mjw_public_subnet.id
    assign_private_dns_record = true
    hostname_label            = format("%sDbVm", lower(replace(var.app_name, "/\\s/", "")))
    display_name              = format("%sDbVnic", replace(title(var.app_name), "/\\s/", ""))
    private_ip                = join(".", ["10", "0", "0", 110])
    nsg_ids                   = [oci_core_network_security_group.mjw_network_security_group.id]
    freeform_tags             = var.tags
  }

  agent_config {
    are_all_plugins_disabled = true
    is_management_disabled   = true
    is_monitoring_disabled   = true
  }
}
