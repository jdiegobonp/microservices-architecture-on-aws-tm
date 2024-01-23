stack {
  name = "ECS Cluster Terramate Stack"

  tags = [
    "sandbox",
    "microservices",
    "ecs",
    "cluster"
  ]

  after = [
    "../ec2"
  ]
}
import {
  source = "/modules/ecs-cluster/ecs-cluster.tm.hcl"
}
import {
  source = "/modules/ecs-cluster/outputs.tm.hcl"
}