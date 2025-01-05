

resource "oci_core_instance" "mjw_vm_app" {

  for_each                            = var.app_instance_enabled ? { "app_instance" : "enabled" } : {}
  availability_domain                 = data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain_number].name
  compartment_id                      = var.compartment_ocid
  shape                               = "VM.Standard.A1.Flex"
  display_name                        = format("%sAppVm", replace(title(var.app_name), "/\\s/", ""))
  preserve_boot_volume                = false
  is_pv_encryption_in_transit_enabled = true
  freeform_tags                       = var.tags


  shape_config {
    memory_in_gbs = var.vm_app_memory
    ocpus         = var.vm_app_ocpus
  }


  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = base64encode(join("\n", [
      file("./init-script/compute-common.sh"),
      "${templatefile("${path.module}/init-script/compute-env.sh", {
        POSTGRES_PASSWORD = var.postgres_password
      POSTGRES_USER = var.postgres_user })}",

      file("./init-script/compute-app.sh")
    ]))
  }



  source_details {
    source_id               = var.instance_image_ocid[var.region]
    source_type             = var.instance_source_type
    boot_volume_size_in_gbs = var.vm_boot_volume_size
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
    hostname_label            = format("%sAppVm", lower(replace(var.app_name, "/\\s/", "")))
    display_name              = format("%sAppVnic", replace(title(var.app_name), "/\\s/", ""))
    private_ip                = join(".", ["10", "0", "0", 112])
    nsg_ids                   = [oci_core_network_security_group.mjw_network_security_group.id]
    freeform_tags             = var.tags
  }

  agent_config {
    are_all_plugins_disabled = true
    is_management_disabled   = true
    is_monitoring_disabled   = true
  }
}
