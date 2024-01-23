generate_hcl "_tm_ec2.tf" {

  content {

    resource "aws_instance" "database" {
      ami                    = data.aws_ssm_parameter.ubuntu1804.value
      instance_type          = "t3.micro"
      subnet_id              = data.terraform_remote_state.vpc.outputs.private_subnets[0]
      vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.sg_database_id]
      private_ip             = global.database_private_ip
      key_name               = global.ec2_key_pair
      tags                   = { "Name" = "${global.project_tag}-database" }

      user_data = base64encode(templatefile("${terramate.root.path.fs.absolute}/scripts/database.sh", {
        DATABASE_SERVICE_NAME = global.database_service_name
        DATABASE_MESSAGE      = global.database_message
      }))

    }

    resource "aws_instance" "consul_server" {
      count = global.consul_server_count

      ami                         = data.aws_ssm_parameter.ubuntu1804.value
      instance_type               = "t3.micro"
      subnet_id                   = data.terraform_remote_state.vpc.outputs.private_subnets[count.index]
      associate_public_ip_address = false
      key_name                    = global.ec2_key_pair

      vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.sg_consul_server_alb_id]
      private_ip             = global.server_private_ips[count.index]

      iam_instance_profile = data.terraform_remote_state.iam.outputs.consul_instance_profile_name

      tags = { "Name" = "${global.project_tag}-consul-server" }

      user_data = base64encode(templatefile("${terramate.root.path.fs.absolute}/scripts/server.sh", {
        CA_PUBLIC_KEY             = data.terraform_remote_state.tls.outputs.tls_self_signed_cert_pem
        CONSUL_SERVER_PUBLIC_KEY  = data.terraform_remote_state.tls.outputs.tls_locally_signed_cert_pem
        CONSUL_SERVER_PRIVATE_KEY = data.terraform_remote_state.tls.outputs.tls_private_key_pem
        CONSUL_BOOTSTRAP_TOKEN    = random_uuid.consul_bootstrap_token.result
        CONSUL_GOSSIP_KEY         = random_id.consul_gossip_key.b64_std
        CONSUL_SERVER_COUNT       = global.consul_server_count
        CONSUL_SERVER_DATACENTER  = global.consul_dc1_name
        AUTO_JOIN_TAG             = "Name"
        AUTO_JOIN_TAG_VALUE       = "${global.project_tag}-consul-server"
        SERVICE_NAME_PREFIX = global.project_tag
      }))
    }
  }
 }