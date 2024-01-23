stack {
  name = "EC2 Consul Servers Terramate Stack"

  tags = [
    "sandbox",
    "microservices",
    "ec2",
    "consul"
  ]

  after = [
    "../../bootstrap/vpc",
    "../../bootstrap/iam",
    "../../bootstrap/security-group",
    "../../bootstrap/tls"
  ]
}
import {
  source = "/modules/ec2/ec2.tm.hcl"
}
import {
  source = "/modules/ec2/outputs.tm.hcl"
}
import {
  source = "/modules/ec2/data.tm.hcl"
}