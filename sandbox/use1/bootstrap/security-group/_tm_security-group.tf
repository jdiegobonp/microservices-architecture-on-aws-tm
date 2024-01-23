// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

resource "aws_security_group" "client_alb" {
  description = "security group for client service application load balancer"
  name_prefix = "jadegproj-ecs-client-alb"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
}
resource "aws_security_group_rule" "client_alb_allow_80" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]
  description = "Allow HTTP traffic."
  from_port   = 80
  ipv6_cidr_blocks = [
    "::/0",
  ]
  protocol          = "tcp"
  security_group_id = aws_security_group.client_alb.id
  to_port           = 80
  type              = "ingress"
}
resource "aws_security_group_rule" "client_alb_allow_outbound" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]
  description = "Allow any outbound traffic."
  from_port   = 0
  ipv6_cidr_blocks = [
    "::/0",
  ]
  protocol          = "-1"
  security_group_id = aws_security_group.client_alb.id
  to_port           = 0
  type              = "egress"
}
resource "aws_security_group" "ecs_client_service" {
  description = "ECS Client service security group."
  name_prefix = "jadegproj-ecs-client-service"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
}
resource "aws_security_group_rule" "ecs_client_service_allow_9090" {
  description              = "Allow incoming traffic from the client ALB into the service container port."
  from_port                = 9090
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs_client_service.id
  source_security_group_id = aws_security_group.client_alb.id
  to_port                  = 9090
  type                     = "ingress"
}
resource "aws_security_group_rule" "ecs_client_service_allow_inbound_self" {
  description       = "Allow traffic from resources with this security group."
  from_port         = 0
  protocol          = -1
  security_group_id = aws_security_group.ecs_client_service.id
  self              = true
  to_port           = 0
  type              = "ingress"
}
resource "aws_security_group_rule" "ecs_client_service_allow_outbound" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]
  description = "Allow any outbound traffic."
  from_port   = 0
  ipv6_cidr_blocks = [
    "::/0",
  ]
  protocol          = "-1"
  security_group_id = aws_security_group.ecs_client_service.id
  to_port           = 0
  type              = "egress"
}
resource "aws_security_group" "ecs_fruits_service" {
  description = "ECS Fruits service security group."
  name_prefix = "jadegproj-ecs-fruits-service"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
}
resource "aws_security_group_rule" "ecs_fruits_service_allow_inbound_self" {
  description       = "Allow traffic from resources with this security group."
  from_port         = 0
  protocol          = -1
  security_group_id = aws_security_group.ecs_fruits_service.id
  self              = true
  to_port           = 0
  type              = "ingress"
}
resource "aws_security_group_rule" "ecs_fruits_service_allow_outbound" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]
  description = "Allow any outbound traffic."
  from_port   = 0
  ipv6_cidr_blocks = [
    "::/0",
  ]
  protocol          = "-1"
  security_group_id = aws_security_group.ecs_fruits_service.id
  to_port           = 0
  type              = "egress"
}
resource "aws_security_group" "ecs_vegetables_service" {
  description = "ECS Vegetables service security group."
  name_prefix = "jadegproj-ecs-vegetables-service"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
}
resource "aws_security_group_rule" "ecs_vegetables_service_allow_inbound_self" {
  description       = "Allow traffic from resources with this security group."
  from_port         = 0
  protocol          = -1
  security_group_id = aws_security_group.ecs_vegetables_service.id
  self              = true
  to_port           = 0
  type              = "ingress"
}
resource "aws_security_group_rule" "ecs_vegetables_service_allow_outbound" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]
  description = "Allow any outbound traffic."
  from_port   = 0
  ipv6_cidr_blocks = [
    "::/0",
  ]
  protocol          = "-1"
  security_group_id = aws_security_group.ecs_vegetables_service.id
  to_port           = 0
  type              = "egress"
}
resource "aws_security_group" "database" {
  description = "Database security group."
  name_prefix = "jadegproj-database"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
}
resource "aws_security_group_rule" "database_allow_fruits_27017" {
  description              = "Allow incoming traffic from the Fruits service onto the database port."
  from_port                = 27017
  protocol                 = "tcp"
  security_group_id        = aws_security_group.database.id
  source_security_group_id = aws_security_group.ecs_fruits_service.id
  to_port                  = 27017
  type                     = "ingress"
}
resource "aws_security_group_rule" "database_allow_vegetables_27017" {
  description              = "Allow incoming traffic from the Vegetables service onto the database port."
  from_port                = 27017
  protocol                 = "tcp"
  security_group_id        = aws_security_group.database.id
  source_security_group_id = aws_security_group.ecs_vegetables_service.id
  to_port                  = 27017
  type                     = "ingress"
}
resource "aws_security_group_rule" "database_allow_outbound" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]
  description = "Allow any outbound traffic."
  from_port   = 0
  ipv6_cidr_blocks = [
    "::/0",
  ]
  protocol          = "-1"
  security_group_id = aws_security_group.database.id
  to_port           = 0
  type              = "egress"
}
resource "aws_security_group" "consul_server" {
  description = "Security Group for the Consul servers"
  name_prefix = "jadegproj-consul-server"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
}
resource "aws_security_group_rule" "consul_server_allow_server_8300" {
  description       = "Allow RPC traffic from ConsulServer to Server. For data replication between servers."
  from_port         = 8300
  protocol          = "tcp"
  security_group_id = aws_security_group.consul_server.id
  self              = true
  to_port           = 8300
  type              = "ingress"
}
resource "aws_security_group_rule" "consul_server_allow_server_8301" {
  description       = "Allow LAN gossip traffic from ConsulServer to Server. For managing cluster membership, distributed health checks of agents and event broadcasts"
  from_port         = 8301
  protocol          = "tcp"
  security_group_id = aws_security_group.consul_server.id
  self              = true
  to_port           = 8301
  type              = "ingress"
}
resource "aws_security_group_rule" "consul_server_allow_server_8302" {
  description       = "Allow WAN gossip traffic from ConsulServer to Server. For cross-datacenter communication"
  from_port         = 8302
  protocol          = "tcp"
  security_group_id = aws_security_group.consul_server.id
  self              = true
  to_port           = 8302
  type              = "ingress"
}
resource "aws_security_group_rule" "consul_server_allow_alb_8500" {
  description              = "Allow HTTP traffic from Load Balancer onto the Consul Server API."
  from_port                = 8500
  protocol                 = "tcp"
  security_group_id        = aws_security_group.consul_server.id
  source_security_group_id = aws_security_group.consul_server_alb.id
  to_port                  = 8500
  type                     = "ingress"
}
resource "aws_security_group_rule" "consul_server_allow_outbound" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]
  description       = "Allow outbound traffic"
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.consul_server.id
  to_port           = 0
  type              = "egress"
}
resource "aws_security_group_rule" "consul_server_allow_server_8501" {
  description       = "Allow HTTPS API traffic from Consul Server to Server."
  from_port         = 8501
  protocol          = "tcp"
  security_group_id = aws_security_group.consul_server.id
  self              = true
  to_port           = 8501
  type              = "ingress"
}
resource "aws_security_group_rule" "consul_server_allow_client_8300" {
  description              = "Allow RPC traffic from Consul Client to Server.  For data replication between servers."
  from_port                = 8300
  protocol                 = "tcp"
  security_group_id        = aws_security_group.consul_server.id
  source_security_group_id = aws_security_group.consul_client.id
  to_port                  = 8300
  type                     = "ingress"
}
resource "aws_security_group_rule" "consul_server_allow_client_8301" {
  description              = "Allow LAN gossip traffic from Consul Client to Server.  For data replication between servers."
  from_port                = 8301
  protocol                 = "tcp"
  security_group_id        = aws_security_group.consul_server.id
  source_security_group_id = aws_security_group.consul_client.id
  to_port                  = 8301
  type                     = "ingress"
}
resource "aws_security_group_rule" "consul_server_allow_client_8500" {
  description              = "Allow HTTP API traffic from Consul Client to Server."
  from_port                = 8500
  protocol                 = "tcp"
  security_group_id        = aws_security_group.consul_server.id
  source_security_group_id = aws_security_group.consul_client.id
  to_port                  = 8500
  type                     = "ingress"
}
resource "aws_security_group_rule" "consul_server_allow_client_8501" {
  description              = "Allow HTTPS API traffic from Consul Client to Server."
  from_port                = 8501
  protocol                 = "tcp"
  security_group_id        = aws_security_group.consul_server.id
  source_security_group_id = aws_security_group.consul_client.id
  to_port                  = 8501
  type                     = "ingress"
}
resource "aws_security_group" "consul_server_alb" {
  description = "Security Group for the ALB fronting the consul server"
  name_prefix = "jadegproj-consul-server-alb"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
}
resource "aws_security_group_rule" "consul_server_alb_allow_80" {
  cidr_blocks = flatten([
    [
      "0.0.0.0/0",
    ],
    [
      "10.0.0.0/16",
    ],
  ])
  description       = "Allow HTTP traffic."
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.consul_server_alb.id
  to_port           = 80
  type              = "ingress"
}
resource "aws_security_group_rule" "consul_server_alb_allow_outbound" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]
  description = "Allow any outbound traffic."
  from_port   = 0
  ipv6_cidr_blocks = [
    "::/0",
  ]
  protocol          = "-1"
  security_group_id = aws_security_group.consul_server_alb.id
  to_port           = 0
  type              = "egress"
}
resource "aws_security_group" "acl_controller" {
  description = "Consul ACL Controller service security group."
  name_prefix = "jadegproj-acl-controller-"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
}
resource "aws_security_group_rule" "acl_controller_allow_inbound_self" {
  description       = "Allow traffic from resources with this security group."
  from_port         = 0
  protocol          = -1
  security_group_id = aws_security_group.acl_controller.id
  self              = true
  to_port           = 0
  type              = "ingress"
}
resource "aws_security_group_rule" "acl_controller_allow_outbound" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]
  description = "Allow any outbound traffic."
  from_port   = 0
  ipv6_cidr_blocks = [
    "::/0",
  ]
  protocol          = "-1"
  security_group_id = aws_security_group.acl_controller.id
  to_port           = 0
  type              = "egress"
}
resource "aws_security_group" "consul_client" {
  description = "General security group for consul clients."
  name_prefix = "jadegproj-consul-client-"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
}
resource "aws_security_group_rule" "consul_client_allow_inbound_self_8301" {
  description       = "Allow LAN Serf traffic from resources with this security group."
  from_port         = 8301
  protocol          = "tcp"
  security_group_id = aws_security_group.consul_client.id
  self              = true
  to_port           = 8301
  type              = "ingress"
}
resource "aws_security_group_rule" "consul_client_allow_inbound_self_20000" {
  description       = "Allow Proxy traffic from resources with this security group."
  from_port         = 20000
  protocol          = "tcp"
  security_group_id = aws_security_group.consul_client.id
  self              = true
  to_port           = 20000
  type              = "ingress"
}
resource "aws_security_group_rule" "consul_client_allow_outbound" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]
  description = "Allow any outbound traffic."
  from_port   = 0
  ipv6_cidr_blocks = [
    "::/0",
  ]
  protocol          = "-1"
  security_group_id = aws_security_group.consul_client.id
  to_port           = 0
  type              = "egress"
}
