# AWS SSM Parameter Store Terraform module

Terraform module which creates [AWS SSM Parameters](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html) on AWS.

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

## Available Features

- One of multiple SSM Parameters can be created
- Value type guesser
- Allow SSM Parameter to ignore changes in the value
- Wrapper module which allows managing multiple resources with less code

## Usage

### Parameter as String

```hcl
module "string" {
  source  = "terraform-aws-modules/ssm-parameter/aws"

  name  = "my-parameter"
  value = "some-value"
}
```

### Parameter as SecureString

```hcl
module "secret" {
  source  = "terraform-aws-modules/ssm-parameter/aws"

  name        = "my-secret-token"
  value       = "secret123123!!!"
  secure_type = true
}
```

### Parameter as StringList

```hcl
module "list" {
  source  = "terraform-aws-modules/ssm-parameter/aws"

  name   = "my-list-parameter"
  values = ["item1", "item2"] # "values" not "value"
}
```

### Parameter with ignored value changes

```hcl
module "list" {
  source  = "terraform-aws-modules/ssm-parameter/aws"

  ignore_value_changes = true

  name  = "my-parameter-ignore-value-changes"
  value = "some-value"
}
```

### Multiple parameters

```hcl
locals {
  parameters = {
    #########
    # String
    #########
    "string_simple" = {
      value = "string_value123"
    }
    "string" = {
      type            = "String"
      value           = "string_value123"
      tier            = "Intelligent-Tiering"
      allowed_pattern = "[a-z0-9_]+"
    }

    ###############
    # SecureString
    ###############
    "secure" = {
      type        = "SecureString"
      value       = "secret123123!!!"
      tier        = "Advanced"
      description = "My awesome password!"
    }
    "secure_encrypted_true" = {
      secure_type = true
      value       = "secret123123!!!"
      key_id      = "c938de44-1c09-4c91-89fd-b5881f06f317"
    }

    #############
    # StringList
    #############
    "list_as_autoguess_type" = {
      values = ["item1", "item2"]
    }
    "list_as_jsonencoded_string" = {
      type  = "StringList"
      value = jsonencode(["item1", "item2"])
    }
    "list_as_plain_string" = {
      type  = "StringList"
      value = "item1,item2"
    }
    "list_as_autoconvert_values" = {
      type   = "StringList"
      values = ["item1", "item2"]
    }
    "list_empty_as_jsonencoded_string" = {
      type  = "StringList"
      value = jsonencode([])
    }
  }
}

module "multiple" {
  source  = "terraform-aws-modules/ssm-parameter/aws"

  for_each = local.parameters

  name            = try(each.value.name, each.key)
  value           = try(each.value.value, null)
  values          = try(each.value.values, [])
  type            = try(each.value.type, null)
  secure_type     = try(each.value.secure_type, null)
  description     = try(each.value.description, null)
  tier            = try(each.value.tier, null)
  key_id          = try(each.value.key_id, null)
  allowed_pattern = try(each.value.allowed_pattern, null)
  data_type       = try(each.value.data_type, null)
}
```

## Module wrappers

Users of this Terraform module can create multiple similar resources by using [`for_each` meta-argument within `module` block](https://www.terraform.io/language/meta-arguments/for_each) which became available in Terraform 0.13.

Users of Terragrunt can achieve similar results by using modules provided in the [wrappers](https://github.com/terraform-aws-modules/terraform-aws-ssm-parameter/tree/master/wrappers) directory, if they prefer to reduce amount of configuration files.


## Examples

- [Complete](https://github.com/terraform-aws-modules/terraform-aws-ssm-parameter/tree/master/examples/complete) - shows all possible ways to create parameters.

## Conditional Creation

The following values are provided to toggle on/off creation of the associated resources as desired:

```hcl
module "parameter" {
  source  = "terraform-aws-modules/ssm-parameter/aws"

  # Disable creation of all resources
  create = false

  # ... omitted
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.37 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.37 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.ignore_value](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_pattern"></a> [allowed\_pattern](#input\_allowed\_pattern) | Regular expression used to validate the parameter value. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create SSM Parameter | `bool` | `true` | no |
| <a name="input_data_type"></a> [data\_type](#input\_data\_type) | Data type of the parameter. Valid values: text, aws:ssm:integration and aws:ec2:image for AMI format. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the parameter | `string` | `null` | no |
| <a name="input_ignore_value_changes"></a> [ignore\_value\_changes](#input\_ignore\_value\_changes) | Whether to create SSM Parameter and ignore changes in value | `bool` | `false` | no |
| <a name="input_key_id"></a> [key\_id](#input\_key\_id) | KMS key ID or ARN for encrypting a parameter (when type is SecureString) | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of SSM parameter | `string` | `null` | no |
| <a name="input_overwrite"></a> [overwrite](#input\_overwrite) | Overwrite an existing parameter. If not specified, defaults to false during create operations to avoid overwriting existing resources and then true for all subsequent operations once the resource is managed by Terraform. Only relevant if ignore\_value\_changes is false. | `bool` | `false` | no |
| <a name="input_secure_type"></a> [secure\_type](#input\_secure\_type) | Whether the type of the value should be considered as secure or not? | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to resources | `map(string)` | `{}` | no |
| <a name="input_tier"></a> [tier](#input\_tier) | Parameter tier to assign to the parameter. If not specified, will use the default parameter tier for the region. Valid tiers are Standard, Advanced, and Intelligent-Tiering. Downgrading an Advanced tier parameter to Standard will recreate the resource. | `string` | `null` | no |
| <a name="input_type"></a> [type](#input\_type) | Type of the parameter. Valid types are String, StringList and SecureString. | `string` | `null` | no |
| <a name="input_value"></a> [value](#input\_value) | Value of the parameter | `string` | `null` | no |
| <a name="input_values"></a> [values](#input\_values) | List of values of the parameter (will be jsonencoded to store as string natively in SSM) | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_insecure_value"></a> [insecure\_value](#output\_insecure\_value) | Insecure value of the parameter |
| <a name="output_raw_value"></a> [raw\_value](#output\_raw\_value) | Raw value of the parameter (as it is stored in SSM). Use 'value' output to get jsondecode'd value |
| <a name="output_secure_type"></a> [secure\_type](#output\_secure\_type) | Whether SSM parameter is a SecureString or not? |
| <a name="output_secure_value"></a> [secure\_value](#output\_secure\_value) | Secure value of the parameter |
| <a name="output_ssm_parameter_arn"></a> [ssm\_parameter\_arn](#output\_ssm\_parameter\_arn) | The ARN of the parameter |
| <a name="output_ssm_parameter_name"></a> [ssm\_parameter\_name](#output\_ssm\_parameter\_name) | Name of the parameter |
| <a name="output_ssm_parameter_tags_all"></a> [ssm\_parameter\_tags\_all](#output\_ssm\_parameter\_tags\_all) | All tags used for the parameter |
| <a name="output_ssm_parameter_type"></a> [ssm\_parameter\_type](#output\_ssm\_parameter\_type) | Type of the parameter |
| <a name="output_ssm_parameter_version"></a> [ssm\_parameter\_version](#output\_ssm\_parameter\_version) | Version of the parameter |
| <a name="output_value"></a> [value](#output\_value) | Parameter value after jsondecode(). Probably this is what you are looking for |
<!-- END_TF_DOCS -->

## Authors

Module is maintained by [Anton Babenko](https://github.com/antonbabenko) with help from [these awesome contributors](https://github.com/terraform-aws-modules/terraform-aws-ssm-parameter/graphs/contributors).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-ssm-parameter/tree/master/LICENSE) for full details.
