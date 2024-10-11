# Complete SSM Parameter Example

Configuration in this directory creates SSM Parameters in all supported configurations.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_disabled"></a> [disabled](#module\_disabled) | ../../ | n/a |
| <a name="module_multiple"></a> [multiple](#module\_multiple) | ../../ | n/a |
| <a name="module_multiple_ignore_value_changes"></a> [multiple\_ignore\_value\_changes](#module\_multiple\_ignore\_value\_changes) | ../../ | n/a |
| <a name="module_wrapper"></a> [wrapper](#module\_wrapper) | ../../wrappers | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

No inputs.

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
