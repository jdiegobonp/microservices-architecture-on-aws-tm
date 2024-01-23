// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

resource "aws_ecs_service" "client" {
  cluster         = data.terraform_remote_state.ecs.outputs.ecs_cluster_arn
  desired_count   = 1
  launch_type     = "FARGATE"
  name            = "jadegproj-client"
  propagate_tags  = "TASK_DEFINITION"
  task_definition = module.client.task_definition_arn
  load_balancer {
    container_name   = "client"
    container_port   = 9090
    target_group_arn = data.terraform_remote_state.ecs-lb.outputs.lb_target_group_client_arn
  }
  network_configuration {
    assign_public_ip = false
    security_groups = [
      data.terraform_remote_state.sg.outputs.sg_ecs_client_service_id,
      data.terraform_remote_state.sg.outputs.sg_consul_client_id,
    ]
    subnets = data.terraform_remote_state.vpc.outputs.private_subnets
  }
}
resource "aws_ecs_service" "fruits" {
  cluster         = data.terraform_remote_state.ecs.outputs.ecs_cluster_arn
  desired_count   = 1
  launch_type     = "FARGATE"
  name            = "jadegproj-fruits"
  propagate_tags  = "TASK_DEFINITION"
  task_definition = module.fruits.task_definition_arn
  network_configuration {
    assign_public_ip = false
    security_groups = [
      data.terraform_remote_state.sg.outputs.sg_ecs_fruits_service_id,
      data.terraform_remote_state.sg.outputs.sg_consul_client_id,
    ]
    subnets = data.terraform_remote_state.vpc.outputs.private_subnets
  }
}
resource "aws_ecs_service" "fruits_v2" {
  cluster         = data.terraform_remote_state.ecs.outputs.ecs_cluster_arn
  desired_count   = 1
  launch_type     = "FARGATE"
  name            = "jadegproj-fruits-v2"
  propagate_tags  = "TASK_DEFINITION"
  task_definition = module.fruits_v2.task_definition_arn
  network_configuration {
    assign_public_ip = false
    security_groups = [
      data.terraform_remote_state.sg.outputs.sg_ecs_fruits_service_id,
      data.terraform_remote_state.sg.outputs.sg_consul_client_id,
    ]
    subnets = data.terraform_remote_state.vpc.outputs.private_subnets
  }
}
resource "aws_ecs_service" "vegetables" {
  cluster         = data.terraform_remote_state.ecs.outputs.ecs_cluster_arn
  desired_count   = 1
  launch_type     = "FARGATE"
  name            = "jadegproj-vegetables"
  propagate_tags  = "TASK_DEFINITION"
  task_definition = module.vegetables.task_definition_arn
  network_configuration {
    assign_public_ip = false
    security_groups = [
      data.terraform_remote_state.sg.outputs.sg_ecs_vegetables_service_id,
      data.terraform_remote_state.sg.outputs.sg_consul_client_id,
    ]
    subnets = data.terraform_remote_state.vpc.outputs.private_subnets
  }
}
module "consul_acl_controller" {
  consul_bootstrap_token_secret_arn = data.terraform_remote_state.ssm.outputs.ssm_consul_bootstrap_token_arn
  consul_server_ca_cert_arn         = data.terraform_remote_state.ssm.outputs.ssm_consul_root_ca_cert_arn
  consul_server_http_addr           = "https://10.0.48.250:8501"
  ecs_cluster_arn                   = data.terraform_remote_state.ecs.outputs.ecs_cluster_arn
  log_configuration                 = data.terraform_remote_state.logs.outputs.acl_logs_configuration
  name_prefix                       = "jadegproj"
  region                            = "us-east-1"
  security_groups = [
    data.terraform_remote_state.sg.outputs.sg_acl_controller_id,
    data.terraform_remote_state.sg.outputs.sg_consul_client_id,
  ]
  source  = "hashicorp/consul-ecs/aws//modules/acl-controller"
  subnets = data.terraform_remote_state.vpc.outputs.private_subnets
  version = "0.4.1"
}
