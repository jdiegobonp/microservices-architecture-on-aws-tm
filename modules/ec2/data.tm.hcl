generate_hcl "_tm_data.tf" {

  content {
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
        bucket = global.tfstate_bucket_name[global.environment]
        key    = "${global.tfstate_bootstrap_base_path}/vpc/${global.tfstate_file}"
        region = global.tfstate_bucket_region
        # assume_role = {
        #   role_arn = global.tfstate_iam_role_arn[global.environment]
        # }
      }
    }

    data "terraform_remote_state" "sg" {
      backend = "s3"
      config = {
        bucket = global.tfstate_bucket_name[global.environment]
        key    = "${global.tfstate_bootstrap_base_path}/security-group/${global.tfstate_file}"
        region = global.tfstate_bucket_region
        # assume_role = {
        #   role_arn = global.tfstate_iam_role_arn[global.environment]
        # }
      }
    }

    data "terraform_remote_state" "iam" {
      backend = "s3"
      config = {
        bucket = global.tfstate_bucket_name[global.environment]
        key    = "${global.tfstate_bootstrap_base_path}/iam/${global.tfstate_file}"
        region = global.tfstate_bucket_region
        # assume_role = {
        #   role_arn = global.tfstate_iam_role_arn[global.environment]
        # }
      }
    }

    data "terraform_remote_state" "tls" {
      backend = "s3"
      config = {
        bucket = global.tfstate_bucket_name[global.environment]
        key    = "${global.tfstate_bootstrap_base_path}/tls/${global.tfstate_file}"
        region = global.tfstate_bucket_region
        # assume_role = {
        #   role_arn = global.tfstate_iam_role_arn[global.environment]
        # }
      }
    }
  }
}