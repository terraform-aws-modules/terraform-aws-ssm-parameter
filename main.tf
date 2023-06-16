locals {
  type = var.type != null ? var.type : (
    length(var.values) > 0 ? "StringList" : (
      can(tostring(var.value)) ? (try(tobool(var.secure_type) == true, false) ? "SecureString" : "String") : "StringList"
  ))
  secure_type = local.type == "SecureString"
  list_type   = local.type == "StringList"
  string_type = local.type == "String"
  value       = local.list_type ? (length(var.values) > 0 ? jsonencode(var.values) : var.value) : var.value
}

resource "aws_ssm_parameter" "this" {
  count = var.create && !var.ignore_value_changes ? 1 : 0

  name        = var.name
  type        = local.type
  description = var.description

  value          = local.secure_type ? local.value : null
  insecure_value = local.list_type || local.string_type ? local.value : null

  tier            = var.tier
  key_id          = local.secure_type ? var.key_id : null
  allowed_pattern = var.allowed_pattern
  data_type       = var.data_type

  tags = var.tags
}

resource "aws_ssm_parameter" "ignore_value" {
  count = var.create && var.ignore_value_changes ? 1 : 0

  name        = var.name
  type        = local.type
  description = var.description

  value          = local.secure_type ? local.value : null
  insecure_value = local.list_type || local.string_type ? local.value : null

  tier            = var.tier
  key_id          = local.secure_type ? var.key_id : null
  allowed_pattern = var.allowed_pattern
  data_type       = var.data_type

  tags = var.tags

  lifecycle {
    ignore_changes = [
      insecure_value,
      value
    ]
  }
}
