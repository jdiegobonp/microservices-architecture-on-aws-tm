generate_hcl "_tm_data.tf" {

  content {
    ## Consul Instance Trust Policy
    data "aws_iam_policy_document" "instance_trust_policy" {
      statement {
        effect = "Allow"
        principals {
          type        = "Service"
          identifiers = ["ec2.amazonaws.com"]
        }
        actions = [
          "sts:AssumeRole"
        ]
      }
    }

    ## Consul Instance Permissions Policy
    data "aws_iam_policy_document" "instance_permissions_policy" {
      statement {
        sid    = "DescribeInstances" # change this to describe instances...
        effect = "Allow"
        actions = [
          "ec2:DescribeInstances"
        ]
        resources = [
          "*"
        ]
      }
    }
  }
}