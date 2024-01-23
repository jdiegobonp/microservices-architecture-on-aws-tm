generate_hcl "_tm_ecs-loadbalancer.tf" {

  content {

    # User Facing Client Application Load Balancer
    resource "aws_lb" "client_alb" {
      name_prefix        = "cl-" # 6 char length
      load_balancer_type = "application"
      security_groups    = [data.terraform_remote_state.sg.outputs.sg_client_alb_id]
      subnets            = data.terraform_remote_state.vpc.outputs.public_subnets
      idle_timeout       = 60
      ip_address_type    = "dualstack"

      tags = { "Name" = "${global.project_tag}-client-alb" }
    }

    # User Facing Client Target Group
    resource "aws_lb_target_group" "client_alb_targets" {
      name_prefix          = "cl-"
      port                 = 9090
      protocol             = "HTTP"
      vpc_id               = data.terraform_remote_state.vpc.outputs.vpc_id
      deregistration_delay = 30
      target_type          = "ip"

      health_check {
        enabled             = true
        path                = "/"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 30
        interval            = 60
        protocol            = "HTTP"
      }

      tags = { "Name" = "${global.project_tag}-client-tg" }
    }

    # User Facing Client ALB Listeners
    resource "aws_lb_listener" "client_alb_http_80" {
      load_balancer_arn = aws_lb.client_alb.arn
      port              = 80
      protocol          = "HTTP"

      default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.client_alb_targets.arn
      }
    }

    # Consul Server Application Load Balancer
    # - this is for the admins to connect to the UI
    resource "aws_lb" "consul_server_alb" {
      name_prefix        = "cs-" # 6 char length
      load_balancer_type = "application"
      security_groups    = [data.terraform_remote_state.sg.outputs.sg_consul_server_alb_id]
      subnets            = data.terraform_remote_state.vpc.outputs.public_subnets
      idle_timeout       = 60
      ip_address_type    = "dualstack"

      tags = { "Name" = "${global.project_tag}-consul-server-alb" }
    }

    # Consul Server Target Group
    resource "aws_lb_target_group" "consul_server_alb_targets" {
      name_prefix          = "cs-"
      port                 = 8500
      protocol             = "HTTP"
      vpc_id               = data.terraform_remote_state.vpc.outputs.vpc_id
      deregistration_delay = 30
      target_type          = "instance"

      health_check {
        enabled             = true
        path                = "/v1/status/leader"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 30
        interval            = 60
        protocol            = "HTTP"
      }

      tags = { "Name" = "${global.project_tag}-consul-server-tg" }
    }

    resource "aws_lb_target_group_attachment" "consul_server" {
      count            = global.consul_server_count
      target_group_arn = aws_lb_target_group.consul_server_alb_targets.arn
      target_id        = data.terraform_remote_state.ec2.outputs.ec2_consul_servers[count.index]
      port             = 8500
    }

    # Consul Server ALB Listeners
    resource "aws_lb_listener" "consul_server_alb_http_80" {
      load_balancer_arn = aws_lb.consul_server_alb.arn
      port              = 80
      protocol          = "HTTP"

      default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.consul_server_alb_targets.arn
      }
    }

  }
 }