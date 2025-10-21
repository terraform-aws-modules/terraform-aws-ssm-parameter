module "wrapper" {
  source = "../"

  for_each = var.items

  allowed_pattern      = try(each.value.allowed_pattern, var.defaults.allowed_pattern, null)
  create               = try(each.value.create, var.defaults.create, true)
  data_type            = try(each.value.data_type, var.defaults.data_type, null)
  description          = try(each.value.description, var.defaults.description, null)
  ignore_value_changes = try(each.value.ignore_value_changes, var.defaults.ignore_value_changes, false)
  key_id               = try(each.value.key_id, var.defaults.key_id, null)
  name                 = try(each.value.name, var.defaults.name, null)
  overwrite            = try(each.value.overwrite, var.defaults.overwrite, false)
  secure_type          = try(each.value.secure_type, var.defaults.secure_type, false)
  tags                 = try(each.value.tags, var.defaults.tags, {})
  tier                 = try(each.value.tier, var.defaults.tier, null)
  type                 = try(each.value.type, var.defaults.type, null)
  value                = try(each.value.value, var.defaults.value, null)
  values               = try(each.value.values, var.defaults.values, [])
}
