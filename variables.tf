variable "create" {
  description = "Whether to create SSM Parameter"
  type        = bool
  default     = true
}

variable "region" {
  description = "Region where the resource(s) will be managed. Defaults to the Region set in the provider configuration"
  type        = string
  default     = null
}

variable "ignore_value_changes" {
  description = "Whether to create SSM Parameter and ignore changes in value"
  type        = bool
  default     = false
}

variable "secure_type" {
  description = "Whether the type of the value should be considered as secure or not"
  type        = bool
  default     = false
}

################################################################################
# SSM Parameter
################################################################################

variable "allowed_pattern" {
  description = "Regular expression used to validate the parameter value"
  type        = string
  default     = null
}

variable "data_type" {
  description = "Data type of the parameter. Valid values: `text`, `aws:ssm:integration` and `aws:ec2:image` for AMI format, see the [Native parameter support for Amazon Machine Image IDs](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-ec2-aliases.html)"
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the parameter"
  type        = string
  default     = null
}

variable "key_id" {
  description = "KMS key ID or ARN for encrypting a `SecureString`"
  type        = string
  default     = null
}

variable "name" {
  description = "Name of the parameter. If the name contains a path (e.g., any forward slashes (`/`)), it must be fully qualified with a leading forward slash (`/`)"
  type        = string
  default     = null
}

variable "overwrite" {
  description = "Overwrite an existing parameter. If not specified, defaults to `false` during create operations to avoid overwriting existing resources and then `true` for all subsequent operations once the resource is managed by Terraform"
  type        = bool
  default     = null
}

variable "tier" {
  description = "Parameter tier to assign to the parameter. If not specified, will use the default parameter tier for the region. Valid tiers are Standard, Advanced, and Intelligent-Tiering. Downgrading an Advanced tier parameter to Standard will recreate the resource"
  type        = string
  default     = null
}

variable "type" {
  description = "Type of the parameter. Valid types are `String`, `StringList` and `SecureString`"
  type        = string
  default     = null
}

variable "value" {
  description = "Value of the parameter"
  type        = string
  default     = null
}

variable "values" {
  description = "List of values of the parameter (will be jsonencoded to store as string natively in SSM)"
  type        = list(string)
  default     = []
}

variable "value_wo_version" {
  description = "Value of the parameter. This value is always marked as sensitive in the Terraform plan output, regardless of type. Additionally, write-only values are never stored to state. `value_wo_version` can be used to trigger an update and is required with this argument"
  type        = number
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
