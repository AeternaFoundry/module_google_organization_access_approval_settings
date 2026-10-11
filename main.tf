resource "google_organization_access_approval_settings" "organization_access_approval_settings" {
  for_each = var.organization_access_approval_settings

  organization_id     = each.value.organization_id
  active_key_version  = each.value.active_key_version
  deletion_policy     = each.value.deletion_policy
  notification_emails = each.value.notification_emails

  dynamic "enrolled_services" {
    for_each = each.value.enrolled_services
    content {
      cloud_product    = enrolled_services.value.cloud_product
      enrollment_level = enrolled_services.value.enrollment_level
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

