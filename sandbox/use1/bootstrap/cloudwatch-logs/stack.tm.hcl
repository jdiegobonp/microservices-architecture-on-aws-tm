stack {
  name = "CloudWatch Logs Terramate Stack"

  tags = [
    "sandbox",
    "microservices",
    "logs",
  ]
}
import {
  source = "/modules/cloudwatch-logs/cloudwatch-logs.tm.hcl"
}
import {
  source = "/modules/cloudwatch-logs/outputs.tm.hcl"
}