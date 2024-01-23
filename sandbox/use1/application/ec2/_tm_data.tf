// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

data "aws_ssm_parameter" "ubuntu1804" {
  name = "/aws/service/canonical/ubuntu/server/18.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}
resource "random_id" "consul_gossip_key" {
  byte_length = 32
}
resource "random_uuid" "consul_bootstrap_token" {
}
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "jdiegobonp-tfstate-sandbox"
    key    = "sandbox/339712908730/use1/bootstrap/vpc/terraform.tfstate"
    region = "us-east-1"
  }
}
data "terraform_remote_state" "sg" {
  backend = "s3"
  config = {
    bucket = "jdiegobonp-tfstate-sandbox"
    key    = "sandbox/339712908730/use1/bootstrap/security-group/terraform.tfstate"
    region = "us-east-1"
  }
}
data "terraform_remote_state" "iam" {
  backend = "s3"
  config = {
    bucket = "jdiegobonp-tfstate-sandbox"
    key    = "sandbox/339712908730/use1/bootstrap/iam/terraform.tfstate"
    region = "us-east-1"
  }
}
data "terraform_remote_state" "tls" {
  backend = "s3"
  config = {
    bucket = "jdiegobonp-tfstate-sandbox"
    key    = "sandbox/339712908730/use1/bootstrap/tls/terraform.tfstate"
    region = "us-east-1"
  }
}
