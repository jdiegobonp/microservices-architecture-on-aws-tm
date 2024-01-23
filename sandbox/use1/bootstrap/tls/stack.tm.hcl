stack {
  name = "TLS Terramate Stack"

  tags = [
    "sandbox",
    "microservices",
    "tls",
  ]
}
import {
  source = "/modules/tls/tls.tm.hcl"
}
import {
  source = "/modules/tls/outputs.tm.hcl"
}