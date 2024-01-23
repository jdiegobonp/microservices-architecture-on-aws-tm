generate_hcl "_tm_ecs-cluster.tf" {

  content {
    resource "aws_ecs_cluster" "main" {
      name = global.project_tag
    }
  }
 }