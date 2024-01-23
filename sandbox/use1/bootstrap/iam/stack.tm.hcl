stack {
  name = "IAM Terramate Stack"

  tags = [
    "sandbox",
    "microservices",
    "iam",
  ]

  after = [
    "../vpc"
  ]
}
import {
  source = "/modules/iam/data.tm.hcl"
}
import {
  source = "/modules/iam/iam.tm.hcl"
}
import {
  source = "/modules/iam/outputs.tm.hcl"
}