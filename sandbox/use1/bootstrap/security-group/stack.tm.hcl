stack {
  name = "Security Group Terramate Stack"

  tags = [
    "sandbox",
    "microservices",
    "security_group",
  ]

  after = [
    "../vpc",
    "../tls",
  ]
}
import {
  source = "/modules/security-group/data.tm.hcl"
}
import {
  source = "/modules/security-group/outputs.tm.hcl"
}
import {
  source = "/modules/security-group/security-group.tm.hcl"
}