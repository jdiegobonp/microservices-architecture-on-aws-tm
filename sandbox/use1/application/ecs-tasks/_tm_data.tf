// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

data "terraform_remote_state" "ecs" {
  backend = "s3"
  config = {
    bucket = "jdiegobonp-tfstate-sandbox"
    key    = "sandbox/339712908730/use1/application/ecs-cluster/terraform.tfstate"
    region = "us-east-1"
  }
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
data "terraform_remote_state" "ssm" {
  backend = "s3"
  config = {
    bucket = "jdiegobonp-tfstate-sandbox"
    key    = "sandbox/339712908730/use1/bootstrap/secrets-manager/terraform.tfstate"
    region = "us-east-1"
  }
}
data "terraform_remote_state" "logs" {
  backend = "s3"
  config = {
    bucket = "jdiegobonp-tfstate-sandbox"
    key    = "sandbox/339712908730/use1/bootstrap/cloudwatch-logs/terraform.tfstate"
    region = "us-east-1"
  }
}
data "terraform_remote_state" "ecs-lb" {
  backend = "s3"
  config = {
    bucket = "jdiegobonp-tfstate-sandbox"
    key    = "sandbox/339712908730/use1/application/ecs-loadbalancer/terraform.tfstate"
    region = "us-east-1"
  }
}
