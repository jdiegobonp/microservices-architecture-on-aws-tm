stack {
  name = "Secrets Manager Terramate Stack"

  tags = [
    "sandbox",
    "microservices",
    "secrets_manager",
  ]

  after = [
    "../tls",
  ]
}
import {
  source = "/modules/secrets-manager/data.tm.hcl"
}
import {
  source = "/modules/secrets-manager/secrets-manager.tm.hcl"
}
import {
  source = "/modules/secrets-manager/outputs.tm.hcl"
}