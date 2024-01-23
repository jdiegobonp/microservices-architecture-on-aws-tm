generate_hcl "_tm_iam.tf" {

  content {
    # Consul Instance Role
    resource "aws_iam_role" "consul_instance" {
      name_prefix        = "${global.project_tag}-role"
      assume_role_policy = data.aws_iam_policy_document.instance_trust_policy.json
    }

    ## Consul Instance Role <> Policy Attachment
    resource "aws_iam_role_policy" "consul_instance_policy" {
      name_prefix = "${global.project_tag}-instance-policy"
      role        = aws_iam_role.consul_instance.id
      policy      = data.aws_iam_policy_document.instance_permissions_policy.json
    }

    ## Consul Instance Profile <> Role Attachment
    resource "aws_iam_instance_profile" "consul_instance_profile" {
      name        = "${global.project_tag}-instance-profile"
      role        = aws_iam_role.consul_instance.name
    }
  }
 }