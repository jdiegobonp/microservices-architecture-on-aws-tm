generate_hcl "_tm_data.tf" {
  content {
    data "terraform_remote_state" "vpc" {
      backend = "s3"
      config = {
        bucket = global.tfstate_bucket_name[global.environment]
        key    = "${global.tfstate_base_path}/vpc/${global.tfstate_file}"
        region = global.tfstate_bucket_region
        # assume_role = {
        #   role_arn = global.tfstate_iam_role_arn[global.environment]
        # }
      }
    }
  }
}