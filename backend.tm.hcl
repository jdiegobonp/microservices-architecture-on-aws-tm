# Generate '_terramate_generated_backend.tf' in each stack for Remote Terraform Cloud
generate_hcl "_tm_backend.tf" {
  content {
    terraform {
      backend "s3" {
        bucket         = global.tfstate_bucket_name["${global.environment}"]
        key            = "${global.tfstate_base_path}/${terramate.stack.path.basename}/${global.tfstate_file}"
        region         = global.tfstate_bucket_region
        dynamodb_table = global.tfstate_dynamodb_table_lock
      }
    }
  }
}