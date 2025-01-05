
resource "oci_budget_budget" "mjw_budget" {
  amount                                = "20"
  budget_processing_period_start_offset = "1"
  compartment_id                        = var.tenancy_ocid
  freeform_tags                         = var.tags
  description                           = "Budget for Mjw Dev"
  display_name                          = format("%sBudget", replace(title(var.app_name), "/\\s/", ""))
  processing_period_type                = "MONTH"
  reset_period                          = "MONTHLY"
  target_type                           = "COMPARTMENT"
  targets = [
    var.compartment_ocid,
  ]

}

resource "oci_budget_alert_rule" "mjw_budget_alert_rule" {
  budget_id      = oci_budget_budget.mjw_budget.id
  freeform_tags  = var.tags
  display_name   = format("%sAlertRule", replace(title(var.app_name), "/\\s/", ""))
  message        = var.budget_alert_message
  recipients     = "narendra.shuklauk@gmail.com"
  threshold      = "50"
  threshold_type = "PERCENTAGE"
  type           = "ACTUAL"


}

