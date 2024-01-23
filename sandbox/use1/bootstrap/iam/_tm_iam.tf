// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

resource "aws_iam_role" "consul_instance" {
  assume_role_policy = data.aws_iam_policy_document.instance_trust_policy.json
  name_prefix        = "jadegproj-role"
}
resource "aws_iam_role_policy" "consul_instance_policy" {
  name_prefix = "jadegproj-instance-policy"
  policy      = data.aws_iam_policy_document.instance_permissions_policy.json
  role        = aws_iam_role.consul_instance.id
}
resource "aws_iam_instance_profile" "consul_instance_profile" {
  name = "jadegproj-instance-profile"
  role = aws_iam_role.consul_instance.name
}
