// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  backend "s3" {
    bucket         = "jdiegobonp-tfstate-sandbox"
    dynamodb_table = "jdiegobonp-tflock-sandbox"
    key            = "sandbox/339712908730/use1/bootstrap/security-group/terraform.tfstate"
    region         = "us-east-1"
  }
}
