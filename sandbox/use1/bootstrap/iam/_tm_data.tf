// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

data "aws_iam_policy_document" "instance_trust_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]
    effect = "Allow"
    principals {
      identifiers = [
        "ec2.amazonaws.com",
      ]
      type = "Service"
    }
  }
}
data "aws_iam_policy_document" "instance_permissions_policy" {
  statement {
    actions = [
      "ec2:DescribeInstances",
    ]
    effect = "Allow"
    resources = [
      "*",
    ]
    sid = "DescribeInstances"
  }
}
