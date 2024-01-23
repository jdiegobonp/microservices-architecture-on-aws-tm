// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "client" {
  acl_secret_name_prefix         = "jadegproj"
  acls                           = true
  consul_client_token_secret_arn = module.consul_acl_controller.client_token_secret_arn
  consul_datacenter              = "dc1"
  consul_server_ca_cert_arn      = data.terraform_remote_state.ssm.outputs.ssm_consul_root_ca_cert_arn
  container_definitions = [
    {
      name      = "client"
      image     = "nicholasjackson/fake-service:v0.23.1"
      cpu       = 0
      essential = true
      portMappings = [
        {
          containerPort = 9090
          hostPort      = 9090
          protocol      = "tcp"
        },
      ]
      logConfiguration = data.terraform_remote_state.logs.outputs.client_logs_configuration
      environment = [
        {
          name  = "NAME"
          value = "client"
        },
        {
          name  = "MESSAGE"
          value = "Hello from the client!"
        },
        {
          name  = "UPSTREAM_URIS"
          value = "http://localhost:1234,http://localhost:1235"
        },
      ]
    },
  ]
  cpu = 256
  depends_on = [
    module.consul_acl_controller,
  ]
  family                = "jadegproj-client"
  gossip_key_secret_arn = data.terraform_remote_state.ssm.outputs.ssm_consul_gossip_key_arn
  log_configuration     = data.terraform_remote_state.logs.outputs.client_sidecars_log_configuration
  memory                = 512
  port                  = "9090"
  requires_compatibilities = [
    "FARGATE",
  ]
  retry_join = [
    "10.0.48.250",
    "10.0.64.250",
    "10.0.80.250",
  ]
  source = "hashicorp/consul-ecs/aws//modules/mesh-task"
  tls    = true
  upstreams = [
    {
      destinationName = "jadegproj-fruits"
      localBindPort   = 1234
    },
    {
      destinationName = "jadegproj-vegetables"
      localBindPort   = 1235
    },
  ]
  version = "0.4.1"
}
module "fruits" {
  acl_secret_name_prefix         = "jadegproj"
  acls                           = true
  consul_client_token_secret_arn = module.consul_acl_controller.client_token_secret_arn
  consul_datacenter              = "dc1"
  consul_server_ca_cert_arn      = data.terraform_remote_state.ssm.outputs.ssm_consul_root_ca_cert_arn
  container_definitions = [
    {
      name      = "fruits"
      image     = "nicholasjackson/fake-service:v0.23.1"
      cpu       = 0
      essential = true
      portMappings = [
        {
          containerPort = 9090
          hostPort      = 9090
          protocol      = "tcp"
        },
      ]
      logConfiguration = data.terraform_remote_state.logs.outputs.fruits_log_configuration
      environment = [
        {
          name  = "NAME"
          value = "fruits"
        },
        {
          name  = "MESSAGE"
          value = "Hello from the fruits client!"
        },
        {
          name  = "UPSTREAM_URIS"
          value = "http://10.0.48.10:27017"
        },
      ]
    },
  ]
  cpu = 256
  depends_on = [
    module.consul_acl_controller,
  ]
  family                = "jadegproj-fruits"
  gossip_key_secret_arn = data.terraform_remote_state.ssm.outputs.ssm_consul_gossip_key_arn
  log_configuration     = data.terraform_remote_state.logs.outputs.fruits_sidecars_log_configuration
  memory                = 512
  port                  = "9090"
  requires_compatibilities = [
    "FARGATE",
  ]
  retry_join = [
    "10.0.48.250",
    "10.0.64.250",
    "10.0.80.250",
  ]
  source  = "hashicorp/consul-ecs/aws//modules/mesh-task"
  tls     = true
  version = "0.4.1"
}
module "fruits_v2" {
  acl_secret_name_prefix         = "jadegproj"
  acls                           = true
  consul_client_token_secret_arn = module.consul_acl_controller.client_token_secret_arn
  consul_datacenter              = "dc1"
  consul_server_ca_cert_arn      = data.terraform_remote_state.ssm.outputs.ssm_consul_root_ca_cert_arn
  container_definitions = [
    {
      name      = "fruits"
      image     = "nicholasjackson/fake-service:v0.23.1"
      cpu       = 0
      essential = true
      portMappings = [
        {
          containerPort = 9090
          hostPort      = 9090
          protocol      = "tcp"
        },
      ]
      logConfiguration = data.terraform_remote_state.logs.outputs.fruits_v2_log_configuration
      environment = [
        {
          name  = "NAME"
          value = "fruits"
        },
        {
          name  = "MESSAGE"
          value = "Hello from the fruits service version 2!"
        },
        {
          name  = "UPSTREAM_URIS"
          value = "http://10.0.48.10:27017"
        },
      ]
    },
  ]
  cpu = 256
  depends_on = [
    module.consul_acl_controller,
  ]
  family                = "jadegproj-fruits-v2"
  gossip_key_secret_arn = data.terraform_remote_state.ssm.outputs.ssm_consul_gossip_key_arn
  log_configuration     = data.terraform_remote_state.logs.outputs.fruits_v2_sidecars_log_configuration
  memory                = 512
  port                  = "9090"
  requires_compatibilities = [
    "FARGATE",
  ]
  retry_join = [
    "10.0.48.250",
    "10.0.64.250",
    "10.0.80.250",
  ]
  source  = "hashicorp/consul-ecs/aws//modules/mesh-task"
  tls     = true
  version = "0.4.1"
}
module "vegetables" {
  acl_secret_name_prefix         = "jadegproj"
  acls                           = true
  consul_client_token_secret_arn = module.consul_acl_controller.client_token_secret_arn
  consul_datacenter              = "dc1"
  consul_server_ca_cert_arn      = data.terraform_remote_state.ssm.outputs.ssm_consul_root_ca_cert_arn
  container_definitions = [
    {
      name      = "vegetables"
      image     = "nicholasjackson/fake-service:v0.23.1"
      cpu       = 0
      essential = true
      portMappings = [
        {
          containerPort = 9090
          hostPort      = 9090
          protocol      = "tcp"
        },
      ]
      logConfiguration = data.terraform_remote_state.logs.outputs.vegetables_log_configuration
      environment = [
        {
          name  = "NAME"
          value = "vegetables"
        },
        {
          name  = "MESSAGE"
          value = "Hello from the vegetables client!"
        },
        {
          name  = "UPSTREAM_URIS"
          value = "http://10.0.48.10:27017"
        },
      ]
    },
  ]
  cpu = 256
  depends_on = [
    module.consul_acl_controller,
  ]
  family                = "jadegproj-vegetables"
  gossip_key_secret_arn = data.terraform_remote_state.ssm.outputs.ssm_consul_gossip_key_arn
  log_configuration     = data.terraform_remote_state.logs.outputs.vegetables_sidecars_log_configuration
  memory                = 512
  port                  = "9090"
  requires_compatibilities = [
    "FARGATE",
  ]
  retry_join = [
    "10.0.48.250",
    "10.0.64.250",
    "10.0.80.250",
  ]
  source  = "hashicorp/consul-ecs/aws//modules/mesh-task"
  tls     = true
  version = "0.4.1"
}
