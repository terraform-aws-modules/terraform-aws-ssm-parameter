#######################
# SSM Parameter values
#######################

output "raw_value" {
  description = "Raw value of the parameter (as it is stored in SSM). Use 'value' output to get jsondecode'd value"
  value       = { for k, v in module.multiple : k => nonsensitive(v.raw_value) }
  sensitive   = false
}

output "value" {
  description = "Parameter value after jsondecode(). Probably this is what you are looking for"
  value       = { for k, v in module.multiple : k => v.value }
}

output "insecure_value" {
  description = "Insecure value of the parameter"
  value       = { for k, v in module.multiple : k => v.insecure_value }
  sensitive   = false
}

output "secure_value" {
  description = "Secure value of the parameter"
  value       = { for k, v in module.multiple : k => nonsensitive(v.secure_value) }
  sensitive   = false
}

output "secure_type" {
  description = "Whether SSM parameter is a SecureString or not?"
  value       = { for k, v in module.multiple : k => v.secure_type }
  sensitive   = false
}

################
# SSM Parameter
################

output "ssm_parameter_arn" {
  description = "The ARN of the parameter"
  value       = { for k, v in module.multiple : k => v.ssm_parameter_arn }
}

output "ssm_parameter_version" {
  description = "Version of the parameter"
  value       = { for k, v in module.multiple : k => v.ssm_parameter_version }
}

output "ssm_parameter_name" {
  description = "Name of the parameter"
  value       = { for k, v in module.multiple : k => v.ssm_parameter_name }
}

output "ssm_parameter_type" {
  description = "Type of the parameter"
  value       = { for k, v in module.multiple : k => v.ssm_parameter_type }
}

output "ssm_parameter_tags_all" {
  description = "All tags used for the parameter"
  value       = { for k, v in module.multiple : k => v.ssm_parameter_tags_all }
}
