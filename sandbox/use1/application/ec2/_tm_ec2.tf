// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

resource "aws_instance" "database" {
  ami           = data.aws_ssm_parameter.ubuntu1804.value
  instance_type = "t3.micro"
  key_name      = "jadeg"
  private_ip    = "10.0.48.10"
  subnet_id     = data.terraform_remote_state.vpc.outputs.private_subnets[0]
  tags = {
    "Name" = "jadegproj-database"
  }
  user_data = base64encode(templatefile("/Users/juandiego/Sandbox/microservices-architecture-on-aws-tm/scripts/database.sh", {
    DATABASE_SERVICE_NAME = "database"
    DATABASE_MESSAGE      = "Hello from the database"
  }))
  vpc_security_group_ids = [
    data.terraform_remote_state.sg.outputs.sg_database_id,
  ]
}
resource "aws_instance" "consul_server" {
  ami                         = data.aws_ssm_parameter.ubuntu1804.value
  associate_public_ip_address = false
  count                       = 1
  iam_instance_profile        = data.terraform_remote_state.iam.outputs.consul_instance_profile_name
  instance_type               = "t3.micro"
  key_name                    = "jadeg"
  private_ip = [
    "10.0.48.250",
    "10.0.64.250",
    "10.0.80.250",
  ][count.index]
  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnets[count.index]
  tags = {
    "Name" = "jadegproj-consul-server"
  }
  user_data = base64encode(templatefile("/Users/juandiego/Sandbox/microservices-architecture-on-aws-tm/scripts/server.sh", {
    CA_PUBLIC_KEY             = data.terraform_remote_state.tls.outputs.tls_self_signed_cert_pem
    CONSUL_SERVER_PUBLIC_KEY  = data.terraform_remote_state.tls.outputs.tls_locally_signed_cert_pem
    CONSUL_SERVER_PRIVATE_KEY = data.terraform_remote_state.tls.outputs.tls_private_key_pem
    CONSUL_BOOTSTRAP_TOKEN    = random_uuid.consul_bootstrap_token.result
    CONSUL_GOSSIP_KEY         = random_id.consul_gossip_key.b64_std
    CONSUL_SERVER_COUNT       = 1
    CONSUL_SERVER_DATACENTER  = "dc1"
    AUTO_JOIN_TAG             = "Name"
    AUTO_JOIN_TAG_VALUE       = "jadegproj-consul-server"
    SERVICE_NAME_PREFIX       = "jadegproj"
  }))
  vpc_security_group_ids = [
    data.terraform_remote_state.sg.outputs.sg_consul_server_alb_id,
  ]
}
