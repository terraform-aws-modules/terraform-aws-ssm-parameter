variable "create" {
  description = "Whether to create SSM Parameter"
  type        = bool
  default     = true
}

variable "ignore_value_changes" {
  description = "Whether to create SSM Parameter and ignore changes in value"
  type        = bool
  default     = false
}

variable "secure_type" {
  description = "Whether the type of the value should be considered as secure or not?"
  type        = bool
  default     = false
}

################################################################################
# SSM Parameter
################################################################################

variable "name" {
  description = "Name of SSM parameter"
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

variable "description" {
  description = "Description of the parameter"
  type        = string
  default     = null
}

variable "type" {
  description = "Type of the parameter. Valid types are String, StringList and SecureString."
  type        = string
  default     = null
}

variable "tier" {
  description = "Parameter tier to assign to the parameter. If not specified, will use the default parameter tier for the region. Valid tiers are Standard, Advanced, and Intelligent-Tiering. Downgrading an Advanced tier parameter to Standard will recreate the resource."
  type        = string
  default     = null
}

variable "key_id" {
  description = "KMS key ID or ARN for encrypting a parameter (when type is SecureString)"
  type        = string
  default     = null
}

variable "allowed_pattern" {
  description = "Regular expression used to validate the parameter value."
  type        = string
  default     = null
}

variable "data_type" {
  description = "Data type of the parameter. Valid values: text, aws:ssm:integration and aws:ec2:image for AMI format."
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to resources"
  type        = map(string)
  default     = {}
}
