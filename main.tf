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

################################################################################
# SSM Parameter
################################################################################

resource "aws_ssm_parameter" "this" {
  count = var.create && !var.ignore_value_changes ? 1 : 0

  region = var.region

  allowed_pattern  = var.allowed_pattern
  data_type        = var.data_type
  description      = var.description
  insecure_value   = local.list_type || local.string_type ? local.value : null
  key_id           = local.secure_type ? var.key_id : null
  name             = var.name
  overwrite        = var.overwrite
  tier             = var.tier
  type             = local.type
  value            = local.value

  tags = var.tags
}

################################################################################
# SSM Parameter - Ignore Value Changes
################################################################################

resource "aws_ssm_parameter" "ignore_value" {
  count = var.create && var.ignore_value_changes ? 1 : 0

  region = var.region

  allowed_pattern  = var.allowed_pattern
  data_type        = var.data_type
  description      = var.description
  insecure_value   = local.list_type || local.string_type ? local.value : null
  key_id           = local.secure_type ? var.key_id : null
  name             = var.name
  overwrite        = var.overwrite
  tier             = var.tier
  type             = local.type
  value            = local.value


  tags = var.tags

  lifecycle {
    ignore_changes = [
      insecure_value,
      value,
    ]
  }
}
