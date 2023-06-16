module "wrapper" {
  source = "../"

  for_each = var.items

  create               = try(each.value.create, var.defaults.create, true)
  ignore_value_changes = try(each.value.ignore_value_changes, var.defaults.ignore_value_changes, false)
  secure_type          = try(each.value.secure_type, var.defaults.secure_type, false)
  name                 = try(each.value.name, var.defaults.name, null)
  value                = try(each.value.value, var.defaults.value, null)
  values               = try(each.value.values, var.defaults.values, [])
  description          = try(each.value.description, var.defaults.description, null)
  type                 = try(each.value.type, var.defaults.type, null)
  tier                 = try(each.value.tier, var.defaults.tier, null)
  key_id               = try(each.value.key_id, var.defaults.key_id, null)
  allowed_pattern      = try(each.value.allowed_pattern, var.defaults.allowed_pattern, null)
  data_type            = try(each.value.data_type, var.defaults.data_type, null)
  tags                 = try(each.value.tags, var.defaults.tags, {})
}
