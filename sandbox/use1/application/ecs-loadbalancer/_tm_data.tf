// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

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
data "terraform_remote_state" "ec2" {
  backend = "s3"
  config = {
    bucket = "jdiegobonp-tfstate-sandbox"
    key    = "sandbox/339712908730/use1/application/ec2/terraform.tfstate"
    region = "us-east-1"
  }
}
