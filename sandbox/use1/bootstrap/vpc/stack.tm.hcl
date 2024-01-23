stack {
  name = "VPC Terramate Stack"

  tags = [
    "sandbox",
    "microservices",
    "vpc",
  ]
}
import {
  source = "/modules/vpc/vpc.tm.hcl"
}
import {
  source = "/modules/vpc/data.tm.hcl"
}
import {
  source = "/modules/vpc/outputs.tm.hcl"
}