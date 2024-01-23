// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

data "terraform_remote_state" "tls" {
  backend = "s3"
  config = {
    bucket = "jdiegobonp-tfstate-sandbox"
    key    = "sandbox/339712908730/use1/bootstrap/tls/terraform.tfstate"
    region = "us-east-1"
  }
}
