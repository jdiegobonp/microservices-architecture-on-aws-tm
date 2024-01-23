stack {
  name = "ECS LoadBalancer Terramate Stack"

  tags = [
    "sandbox",
    "microservices",
    "ecs",
    "loadbalancer"
  ]

  after = [
    "../../bootstrap/security-group",
    "../../bootstrap/vpc",
    "../ecs-cluster"
  ]
}
import {
  source = "/modules/ecs-loadbalancer/data.tm.hcl"
}
import {
  source = "/modules/ecs-loadbalancer/ecs-loadbalancer.tm.hcl"
}
import {
  source = "/modules/ecs-loadbalancer/outputs.tm.hcl"
}


