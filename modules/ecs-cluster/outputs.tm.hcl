generate_hcl "_tm_outputs.tf" {
  content {
    
    output "ecs_cluster_arn" {
      description = "ARN for the ECS cluster"
      value       = aws_ecs_cluster.main.arn
    }

  }
}