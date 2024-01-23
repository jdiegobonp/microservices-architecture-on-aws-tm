generate_hcl "_tm_ecs-task-definition.tf" {

  content {

    resource "aws_cloudwatch_log_group" "client" {
      name_prefix = "${global.project_tag}-client-"
    }

    resource "aws_cloudwatch_log_group" "client_sidecars" {
      name_prefix = "${global.project_tag}-client-sidecars-"
    }

    resource "aws_cloudwatch_log_group" "fruits" {
      name_prefix = "${global.project_tag}-fruits-"
    }

    resource "aws_cloudwatch_log_group" "fruits_sidecars" {
      name_prefix = "${global.project_tag}-fruits-sidecars-"
    }

    resource "aws_cloudwatch_log_group" "fruits_v2" {
      name_prefix = "${global.project_tag}-fruits-v2-"
    }

    resource "aws_cloudwatch_log_group" "fruits_v2_sidecars" {
      name_prefix = "${global.project_tag}-fruits-v2-sidecars-"
    }

    resource "aws_cloudwatch_log_group" "vegetables" {
      name_prefix = "${global.project_tag}-vegetables-"
    }

    resource "aws_cloudwatch_log_group" "vegetables_sidecars" {
      name_prefix = "${global.project_tag}-vegetables-sidecars-"
    }

    resource "aws_cloudwatch_log_group" "acl" {
      name_prefix = "${global.project_tag}-acl-"
    }

  }
 }