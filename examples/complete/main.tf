provider "aws" {
  region = local.region
}

locals {
  name   = "ex-${basename(path.cwd)}"
  region = "eu-west-1"

  tags = {
    Name       = local.name
    Example    = "complete"
    Repository = "github.com/terraform-aws-modules/terraform-aws-ssm-parameter"
  }

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
    "string_as_ec2_image_data_type" = {
      value     = data.aws_ami.amazon_linux.id
      data_type = "aws:ec2:image"
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
    "secure_true" = {
      secure_type = true
      value       = "secret123123!!!"
    }
    "secure_encrypted_true" = {
      secure_type = true
      value       = "secret123123!!!"
      key_id      = aws_kms_key.this.id
    }
    "secure_as_integration_data_type" = {
      name      = "/d9d01087-4a3f-49e0-b0b4-d568d7826553/ssm/integrations/webhook/mywebhook"
      type      = "SecureString"
      data_type = "aws:ssm:integration"
      value = jsonencode({
        "description" : "My webhook for opsgenie",
        "url" : "https://api.eu.opsgenie.com/v2/alerts",
        "body" : jsonencode({
          "message" : "SSM_ASG_scaledown_test"
        }),
        "headers" : {
          "Content-Type" : "application/json",
          "Authorization" : "MY_SECRET_TOKEN",
          "Method" : "POST"
        }
      })
    }

    #############
    # StringList
    #############
    "list_as_autoguess_type" = {
      # List values should be specified as "values" (not "value")
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
      type = "StringList"
      # List values should be specified as "values" (not "value")
      values = ["item1", "item2"]
    }
    "list_empty_as_jsonencoded_string" = {
      type  = "StringList"
      value = jsonencode([])
    }

    # Invalid values:
    #    # null values can't be stored
    #    "string_null" = {
    #      value = null
    #    }
    #    # empty lists can't be stored
    #    "list_empty_as_plain_string" = {
    #      type  = "StringList"
    #      value = ""
    #    }
    #    "list_empty_as_autoconvert" = {
    #      type   = "StringList"
    #      values = []
    #    }
  }
}

################################################################################
# SSM Parameter Module
################################################################################

module "multiple" {
  source = "../../"

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

  tags = local.tags
}

module "multiple_ignore_value_changes" {
  source = "../../"

  for_each = local.parameters

  ignore_value_changes = true

  name            = format("%s-ignore-value-changes", try(each.value.name, each.key))
  value           = try(each.value.value, null)
  values          = try(each.value.values, [])
  type            = try(each.value.type, null)
  secure_type     = try(each.value.secure_type, null)
  description     = try(each.value.description, null)
  tier            = try(each.value.tier, null)
  key_id          = try(each.value.key_id, null)
  allowed_pattern = try(each.value.allowed_pattern, null)
  data_type       = try(each.value.data_type, null)

  tags = local.tags
}

##########
# Wrapper
##########

locals {
  parameters_for_wrapper = {
    for k, v in local.parameters : k => merge(v, {
      name = format("%s-from-wrapper", try(v.name, k))
      tags = local.tags
    })
  }
}

module "wrapper" {
  source = "../../wrappers"

  items = local.parameters_for_wrapper
}

###########
# Disabled
###########

module "disabled" {
  source = "../../"

  create = false
}

################################################################################
# Supporting resources
################################################################################

resource "aws_kms_key" "this" {}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}
