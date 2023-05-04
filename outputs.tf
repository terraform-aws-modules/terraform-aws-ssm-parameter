#######################
# SSM Parameter values
#######################

locals {
  # Making values nonsensitive, but keeping them in separate locals
  stored_value = one(compact([
    try(nonsensitive(aws_ssm_parameter.this[0].value), null),
    try(nonsensitive(aws_ssm_parameter.ignore_value[0].value), null),
  ]))
  stored_insecure_value = one(compact([
    try(aws_ssm_parameter.this[0].insecure_value, null),
    try(aws_ssm_parameter.ignore_value[0].insecure_value, null),
  ]))
  raw_value = one(compact([local.stored_value, local.stored_insecure_value]))
}

output "raw_value" {
  description = "Raw value of the parameter (as it is stored in SSM). Use 'value' output to get jsondecode'd value"
  value       = local.raw_value
  sensitive   = true
}

output "value" {
  description = "Parameter value after jsondecode(). Probably this is what you are looking for"
  value       = try(jsondecode(local.raw_value), local.raw_value)
  sensitive   = false
}

output "insecure_value" {
  description = "Insecure value of the parameter"
  value       = local.stored_insecure_value
  sensitive   = false
}

output "secure_value" {
  description = "Secure value of the parameter"
  value       = local.stored_value
  sensitive   = true
}

output "secure_type" {
  description = "Whether SSM parameter is a SecureString or not?"
  value       = local.secure_type
}

################
# SSM Parameter
################

output "ssm_parameter_arn" {
  description = "The ARN of the parameter"
  value       = try(aws_ssm_parameter.this[0].arn, aws_ssm_parameter.ignore_value[0].arn, null)
}

output "ssm_parameter_version" {
  description = "Version of the parameter"
  value       = try(aws_ssm_parameter.this[0].version, aws_ssm_parameter.ignore_value[0].version, null)
}

output "ssm_parameter_name" {
  description = "Name of the parameter"
  value       = try(aws_ssm_parameter.this[0].name, aws_ssm_parameter.ignore_value[0].name, null)
}

output "ssm_parameter_type" {
  description = "Type of the parameter"
  value       = try(aws_ssm_parameter.this[0].type, aws_ssm_parameter.ignore_value[0].type, null)
}

output "ssm_parameter_tags_all" {
  description = "All tags used for the parameter"
  value       = try(aws_ssm_parameter.this[0].tags_all, aws_ssm_parameter.ignore_value[0].tags_all, null)
}
