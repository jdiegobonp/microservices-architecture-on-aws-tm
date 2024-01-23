stack {
  name = "ECS Tasks Terramate Stack"

  tags = [
    "sandbox",
    "microservices",
    "ecs",
    "tasks"
  ]

  after = [
    "../ecs-cluster",
    "../ecs-loadbalancer",
    "../../bootstrap/vpc",
    "../../bootstrap/cloudwatch-logs",
    "../../bootstrap/secrets-manager",
    "../../bootstrap/security-group"
  ]
}
import {
  source = "/modules/ecs-task/data.tm.hcl"
}
import {
  source = "/modules/ecs-task/ecs-task.tm.hcl"
}
import {
  source = "/modules/ecs-task/outputs.tm.hcl"
}


