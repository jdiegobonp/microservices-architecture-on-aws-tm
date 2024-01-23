generate_hcl "_tm_ecs-task-definition.tf" {

  content {

    # User Facing Client Task Definition
    # --
    # This is the container that will serve as the entry point for public facing traffic
    module "client" {
      source  = "hashicorp/consul-ecs/aws//modules/mesh-task"
      version = "0.4.1"

      family                   = "${global.project_tag}-client"
      requires_compatibilities = ["FARGATE"]
      # required for Fargate launch type
      memory = 512
      cpu    = 256

      container_definitions = [
        {
          name      = "client"
          image     = "nicholasjackson/fake-service:v0.23.1"
          cpu       = 0 # take up proportional cpu
          essential = true

          portMappings = [
            {
              containerPort = 9090
              hostPort      = 9090 # though, access to the ephemeral port range is needed to connect on EC2, the exact port is required on Fargate from a security group standpoint.
              protocol      = "tcp"
            }
          ]

          logConfiguration = data.terraform_remote_state.logs.outputs.client_logs_configuration

          # Fake Service settings are set via Environment variables
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
            }
          ]
        }
      ]

      # All settings required by the mesh-task module
      acls                           = true
      acl_secret_name_prefix         = global.project_tag
      consul_datacenter              = global.consul_dc1_name
      consul_server_ca_cert_arn      = data.terraform_remote_state.ssm.outputs.ssm_consul_root_ca_cert_arn
      consul_client_token_secret_arn = module.consul_acl_controller.client_token_secret_arn
      gossip_key_secret_arn          = data.terraform_remote_state.ssm.outputs.ssm_consul_gossip_key_arn
      log_configuration              = data.terraform_remote_state.logs.outputs.client_sidecars_log_configuration

      # https://github.com/hashicorp/consul-ecs/blob/main/config/schema.json#L74#
      # to tell the proxy and consul-ecs how to contact the service
      port = "9090"

      tls = true

      # the consul-ecs binary takes a large configuration file: https://github.com/hashicorp/consul-ecs/blob/0817f073c665c3933e9455f477b18500616e7c47/config/schema.json
      # the variable "consul_ecs_config" lets you specify the entire thing
      # however, arguments such as "upstreams" (below) can be used instead to
      # target smaller parts of the config without specifying the entire thing: https://github.com/hashicorp/terraform-aws-consul-ecs/blob/3da977ed327ac9bf37a2083854152c2bb4e1ddac/modules/mesh-task/variables.tf#L303-L305
      upstreams = [
        {
          # Name of the CONSUL Service (not to be confused with the ECS Service)
          # This is specified by setting the "family" name for mesh task modules
          # The "family" will map both to the Consul Service and the ECS Task Definition
          # https://github.com/hashicorp/terraform-aws-consul-ecs/blob/main/modules/mesh-task/main.tf#L187
          # https://github.com/hashicorp/terraform-aws-consul-ecs/blob/v0.3.0/modules/mesh-task/variables.tf#L6-L10
          destinationName = "${global.project_tag}-fruits"
          # This is the port that requests to this service will be sent to, and, the port that the proxy will be
          # listening on LOCALLY.
          # https://github.com/hashicorp/consul-ecs/blob/0817f073c665c3933e9455f477b18500616e7c47/config/schema.json#L326
          # the above link is the value this maps to
          localBindPort = 1234
        },
        {
          # https://github.com/hashicorp/consul-ecs/blob/85755adb288055df92c1880d30f1861db771ca63/subcommand/mesh-init/command_test.go#L77
          # looks like upstreams need different local bind ports, which begs the question of what a localBindPort is even doing
          # I guess this is just what the service points to that the envoy listener goes through
          destinationName = "${global.project_tag}-vegetables"
          localBindPort   = 1235
        }
      ]
      # join on the private IPs, much like the consul config "retry_join" argument
      retry_join = global.server_private_ips

      depends_on = [
        module.consul_acl_controller
      ]

    }

    module "fruits" {
      source  = "hashicorp/consul-ecs/aws//modules/mesh-task"
      version = "0.4.1"

      family                   = "${global.project_tag}-fruits"
      requires_compatibilities = ["FARGATE"]
      # required for Fargate launch type
      memory = 512
      cpu    = 256

      container_definitions = [
        {
          name      = "fruits"
          image     = "nicholasjackson/fake-service:v0.23.1"
          cpu       = 0 # take up proportional cpu
          essential = true

          portMappings = [
            {
              containerPort = 9090
              hostPort      = 9090 # though, access to the ephemeral port range is needed to connect on EC2, the exact port is required on Fargate from a security group standpoint.
              protocol      = "tcp"
            }
          ]

          logConfiguration = data.terraform_remote_state.logs.outputs.fruits_log_configuration

          # Fake Service settings are set via Environment variables
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
              value = "http://${global.database_private_ip}:27017"
            }
          ]
        }
      ]

      acls                           = true
      acl_secret_name_prefix         = global.project_tag
      consul_datacenter              = global.consul_dc1_name
      consul_server_ca_cert_arn      = data.terraform_remote_state.ssm.outputs.ssm_consul_root_ca_cert_arn
      consul_client_token_secret_arn = module.consul_acl_controller.client_token_secret_arn
      gossip_key_secret_arn          = data.terraform_remote_state.ssm.outputs.ssm_consul_gossip_key_arn
      port                           = "9090"
      log_configuration              = data.terraform_remote_state.logs.outputs.fruits_sidecars_log_configuration
      tls                            = true

      # isn't needed right now, because there is no "database" service that consul is aware of
      # upstreams = [
      #   {
      #     # this will not work at the moment, because our database
      #     # isn't set up with consul or registered as a service
      #     destinationName = "${var.aws_default_tags.Project}-database"
      #     localBindPort  = 1234
      #   }
      # ]
      retry_join = global.server_private_ips

      depends_on = [
        module.consul_acl_controller
      ]
    }

    module "fruits_v2" {
      source  = "hashicorp/consul-ecs/aws//modules/mesh-task"
      version = "0.4.1"

      family                   = "${global.project_tag}-fruits-v2"
      requires_compatibilities = ["FARGATE"]
      # required for Fargate launch type
      memory = 512
      cpu    = 256

      container_definitions = [
        {
          name      = "fruits"
          image     = "nicholasjackson/fake-service:v0.23.1"
          cpu       = 0 # take up proportional cpu
          essential = true

          portMappings = [
            {
              containerPort = 9090
              hostPort      = 9090 # though, access to the ephemeral port range is needed to connect on EC2, the exact port is required on Fargate from a security group standpoint.
              protocol      = "tcp"
            }
          ]

          logConfiguration = data.terraform_remote_state.logs.outputs.fruits_v2_log_configuration

          # Fake Service settings are set via Environment variables
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
              value = "http://${global.database_private_ip}:27017"
            }
          ]
        }
      ]

      acls                           = true
      acl_secret_name_prefix         = global.project_tag
      consul_datacenter              = global.consul_dc1_name
      consul_server_ca_cert_arn      = data.terraform_remote_state.ssm.outputs.ssm_consul_root_ca_cert_arn
      consul_client_token_secret_arn = module.consul_acl_controller.client_token_secret_arn
      gossip_key_secret_arn          = data.terraform_remote_state.ssm.outputs.ssm_consul_gossip_key_arn
      port                           = "9090"
      log_configuration              = data.terraform_remote_state.logs.outputs.fruits_v2_sidecars_log_configuration
      tls                            = true
      retry_join = global.server_private_ips
      depends_on = [
        module.consul_acl_controller
      ]
    }

    module "vegetables" {
      source  = "hashicorp/consul-ecs/aws//modules/mesh-task"
      version = "0.4.1"

      family                   = "${global.project_tag}-vegetables"
      requires_compatibilities = ["FARGATE"]
      # required for Fargate launch type
      memory = 512
      cpu    = 256

      container_definitions = [
        {
          name      = "vegetables"
          image     = "nicholasjackson/fake-service:v0.23.1"
          cpu       = 0 # take up proportional cpu
          essential = true

          portMappings = [
            {
              containerPort = 9090
              hostPort      = 9090 # though, access to the ephemeral port range is needed to connect on EC2, the exact port is required on Fargate from a security group standpoint.
              protocol      = "tcp"
            }
          ]

          logConfiguration = data.terraform_remote_state.logs.outputs.vegetables_log_configuration

          # Fake Service settings are set via Environment variables
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
              value = "http://${global.database_private_ip}:27017"
            }
          ]
        }
      ]

      acls                           = true
      acl_secret_name_prefix         = global.project_tag
      consul_datacenter              = global.consul_dc1_name
      consul_server_ca_cert_arn      = data.terraform_remote_state.ssm.outputs.ssm_consul_root_ca_cert_arn
      consul_client_token_secret_arn = module.consul_acl_controller.client_token_secret_arn
      gossip_key_secret_arn          = data.terraform_remote_state.ssm.outputs.ssm_consul_gossip_key_arn
      log_configuration              = data.terraform_remote_state.logs.outputs.vegetables_sidecars_log_configuration
      port                           = "9090"
      tls                            = true
      # upstreams = [
      #   {
      #     # this will not work at the moment, because our database
      #     # isn't set up with consul or registered as a service
      #     destinationName = "${var.aws_default_tags.Project}-database"
      #     localBindPort  = 1234
      #   }
      # ]
      retry_join = global.server_private_ips

      depends_on = [
        module.consul_acl_controller
      ]
    }

  }

}


generate_hcl "_tm_ecs-service.tf" {

  content {
    # User Facing Client Service
    resource "aws_ecs_service" "client" {
      name            = "${global.project_tag}-client"
      cluster         = data.terraform_remote_state.ecs.outputs.ecs_cluster_arn
      task_definition = module.client.task_definition_arn
      desired_count   = 1
      launch_type     = "FARGATE"

      load_balancer {
        target_group_arn = data.terraform_remote_state.ecs-lb.outputs.lb_target_group_client_arn
        container_name   = "client"
        container_port   = 9090
      }

      network_configuration {
        subnets          = data.terraform_remote_state.vpc.outputs.private_subnets  
        assign_public_ip = false
        # defaults to the default VPC security group which allows all traffic from itself and all outbound traffic
        # instead, we define our own for each ECS service!
        security_groups = [data.terraform_remote_state.sg.outputs.sg_ecs_client_service_id, data.terraform_remote_state.sg.outputs.sg_consul_client_id]
      }

      propagate_tags = "TASK_DEFINITION"
    }

    resource "aws_ecs_service" "fruits" {
      name            = "${global.project_tag}-fruits"
      cluster         = data.terraform_remote_state.ecs.outputs.ecs_cluster_arn
      task_definition = module.fruits.task_definition_arn
      desired_count   = 1
      launch_type     = "FARGATE"

      network_configuration {
        subnets          = data.terraform_remote_state.vpc.outputs.private_subnets
        assign_public_ip = false
        # defaults to the default VPC security group which allows all traffic from itself and all outbound traffic
        # instead, we define our own for each ECS service!
        security_groups = [data.terraform_remote_state.sg.outputs.sg_ecs_fruits_service_id, data.terraform_remote_state.sg.outputs.sg_consul_client_id]
      }

      propagate_tags = "TASK_DEFINITION"
    }

    resource "aws_ecs_service" "fruits_v2" {
      name            = "${global.project_tag}-fruits-v2"
      cluster         = data.terraform_remote_state.ecs.outputs.ecs_cluster_arn
      task_definition = module.fruits_v2.task_definition_arn
      desired_count   = 1
      launch_type     = "FARGATE"

      network_configuration {
        subnets          = data.terraform_remote_state.vpc.outputs.private_subnets  
        assign_public_ip = false
        security_groups = [data.terraform_remote_state.sg.outputs.sg_ecs_fruits_service_id, data.terraform_remote_state.sg.outputs.sg_consul_client_id]
      }

      propagate_tags = "TASK_DEFINITION"
    }

    resource "aws_ecs_service" "vegetables" {
      name            = "${global.project_tag}-vegetables"
      cluster         = data.terraform_remote_state.ecs.outputs.ecs_cluster_arn
      task_definition = module.vegetables.task_definition_arn
      desired_count   = 1
      launch_type     = "FARGATE"

      network_configuration {
        subnets          = data.terraform_remote_state.vpc.outputs.private_subnets
        assign_public_ip = false
        # defaults to the default VPC security group which allows all traffic from itself and all outbound traffic
        # instead, we define our own for each ECS service!
        security_groups = [data.terraform_remote_state.sg.outputs.sg_ecs_vegetables_service_id, data.terraform_remote_state.sg.outputs.sg_consul_client_id]
      }

      propagate_tags = "TASK_DEFINITION"
    }

    module "consul_acl_controller" {
      source  = "hashicorp/consul-ecs/aws//modules/acl-controller"
      version = "0.4.1"

      name_prefix     = global.project_tag
      ecs_cluster_arn = data.terraform_remote_state.ecs.outputs.ecs_cluster_arn
      region          = global.default_region

      consul_bootstrap_token_secret_arn = data.terraform_remote_state.ssm.outputs.ssm_consul_bootstrap_token_arn
      consul_server_ca_cert_arn         = data.terraform_remote_state.ssm.outputs.ssm_consul_root_ca_cert_arn

      # Point to a singular server IP.  Even if its not the leader, the request will be forwarded appropriately
      # this keeps us from using the public facing load balancer
      consul_server_http_addr = "https://${global.server_private_ips[0]}:8501"

      # the ACL controller module creates the required IAM role to allow logging
      log_configuration = data.terraform_remote_state.logs.outputs.acl_logs_configuration

      # mapped to an underlying `aws_ecs_service` resource, so its the same format
      security_groups = [data.terraform_remote_state.sg.outputs.sg_acl_controller_id, data.terraform_remote_state.sg.outputs.sg_consul_client_id]

      # mapped to an underlying `aws_ecs_service` resource, so its the same format
      subnets = data.terraform_remote_state.vpc.outputs.private_subnets

    }

  }
 }