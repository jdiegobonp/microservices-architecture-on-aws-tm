// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

resource "aws_lb" "client_alb" {
  idle_timeout       = 60
  ip_address_type    = "dualstack"
  load_balancer_type = "application"
  name_prefix        = "cl-"
  security_groups = [
    data.terraform_remote_state.sg.outputs.sg_client_alb_id,
  ]
  subnets = data.terraform_remote_state.vpc.outputs.public_subnets
  tags = {
    "Name" = "jadegproj-client-alb"
  }
}
resource "aws_lb_target_group" "client_alb_targets" {
  deregistration_delay = 30
  name_prefix          = "cl-"
  port                 = 9090
  protocol             = "HTTP"
  tags = {
    "Name" = "jadegproj-client-tg"
  }
  target_type = "ip"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 60
    path                = "/"
    protocol            = "HTTP"
    timeout             = 30
    unhealthy_threshold = 3
  }
}
resource "aws_lb_listener" "client_alb_http_80" {
  load_balancer_arn = aws_lb.client_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.client_alb_targets.arn
    type             = "forward"
  }
}
resource "aws_lb" "consul_server_alb" {
  idle_timeout       = 60
  ip_address_type    = "dualstack"
  load_balancer_type = "application"
  name_prefix        = "cs-"
  security_groups = [
    data.terraform_remote_state.sg.outputs.sg_consul_server_alb_id,
  ]
  subnets = data.terraform_remote_state.vpc.outputs.public_subnets
  tags = {
    "Name" = "jadegproj-consul-server-alb"
  }
}
resource "aws_lb_target_group" "consul_server_alb_targets" {
  deregistration_delay = 30
  name_prefix          = "cs-"
  port                 = 8500
  protocol             = "HTTP"
  tags = {
    "Name" = "jadegproj-consul-server-tg"
  }
  target_type = "instance"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 60
    path                = "/v1/status/leader"
    protocol            = "HTTP"
    timeout             = 30
    unhealthy_threshold = 3
  }
}
resource "aws_lb_target_group_attachment" "consul_server" {
  count            = 1
  port             = 8500
  target_group_arn = aws_lb_target_group.consul_server_alb_targets.arn
  target_id        = data.terraform_remote_state.ec2.outputs.ec2_consul_servers[count.index]
}
resource "aws_lb_listener" "consul_server_alb_http_80" {
  load_balancer_arn = aws_lb.consul_server_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.consul_server_alb_targets.arn
    type             = "forward"
  }
}
