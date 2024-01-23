// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

output "acl_logs_configuration" {
  description = "acl_logs_configuration"
  value = {
    logDriver = "awslogs"
    options = {
      awslogs-group         = aws_cloudwatch_log_group.acl.name
      awslogs-region        = "us-east-1"
      awslogs-stream-prefix = "jadegproj-acl-"
    }
  }
}
output "client_logs_configuration" {
  description = "client_logs_configuration"
  value = {
    logDriver = "awslogs"
    options = {
      awslogs-group         = aws_cloudwatch_log_group.client.name
      awslogs-region        = "us-east-1"
      awslogs-stream-prefix = "jadegproj-client-"
    }
  }
}
output "client_sidecars_log_configuration" {
  description = "client_sidecars_log_configuration"
  value = {
    logDriver = "awslogs"
    options = {
      awslogs-group         = aws_cloudwatch_log_group.client_sidecars.name
      awslogs-region        = "us-east-1"
      awslogs-stream-prefix = "jadegproj-client-sidecars-"
    }
  }
}
output "fruits_sidecars_log_configuration" {
  description = "fruits_sidecars_log_configuration"
  value = {
    logDriver = "awslogs"
    options = {
      awslogs-group         = aws_cloudwatch_log_group.fruits_sidecars.name
      awslogs-region        = "us-east-1"
      awslogs-stream-prefix = "jadegproj-fruits-sidecars-"
    }
  }
}
output "fruits_log_configuration" {
  description = "fruits_log_configuration"
  value = {
    logDriver = "awslogs"
    options = {
      awslogs-group         = aws_cloudwatch_log_group.fruits.name
      awslogs-region        = "us-east-1"
      awslogs-stream-prefix = "jadegproj-fruits-"
    }
  }
}
output "fruits_v2_log_configuration" {
  description = "fruits_v2_log_configuration"
  value = {
    logDriver = "awslogs"
    options = {
      awslogs-group         = aws_cloudwatch_log_group.fruits_v2.name
      awslogs-region        = "us-east-1"
      awslogs-stream-prefix = "jadegproj-fruits-v2-"
    }
  }
}
output "fruits_v2_sidecars_log_configuration" {
  description = "fruits_v2_sidecars_log_configuration"
  value = {
    logDriver = "awslogs"
    options = {
      awslogs-group         = aws_cloudwatch_log_group.fruits_v2_sidecars.name
      awslogs-region        = "us-east-1"
      awslogs-stream-prefix = "jadegproj-fruits-v2-sidecars-"
    }
  }
}
output "vegetables_log_configuration" {
  description = "vegetables_log_configuration"
  value = {
    logDriver = "awslogs"
    options = {
      awslogs-group         = aws_cloudwatch_log_group.vegetables.name
      awslogs-region        = "us-east-1"
      awslogs-stream-prefix = "jadegproj-vegetables-"
    }
  }
}
output "vegetables_sidecars_log_configuration" {
  description = "vegetables_sidecars_log_configuration"
  value = {
    logDriver = "awslogs"
    options = {
      awslogs-group         = aws_cloudwatch_log_group.vegetables_sidecars.name
      awslogs-region        = "us-east-1"
      awslogs-stream-prefix = "jadegproj-vegetables-sidecars-"
    }
  }
}
