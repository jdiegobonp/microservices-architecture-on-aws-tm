// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

output "sg_consul_client_id" {
  description = "Security Group Id for the General security group for consul clients."
  value       = aws_security_group.consul_client.id
}
output "sg_consul_server_alb_id" {
  description = "Security Group Id for the ALB fronting the consul server"
  value       = aws_security_group.consul_server_alb.id
}
output "sg_consul_server_id" {
  description = "Security Group Id for the Consul servers"
  value       = aws_security_group.consul_server.id
}
output "sg_database_id" {
  description = "Security Group Id the Database"
  value       = aws_security_group.database.id
}
output "sg_ecs_vegetables_service_id" {
  description = "Security Group Id ECS vegetables services"
  value       = aws_security_group.ecs_vegetables_service.id
}
output "sg_ecs_fruits_service_id" {
  description = "Security Group Id ECS fruits service"
  value       = aws_security_group.ecs_fruits_service.id
}
output "sg_ecs_client_service_id" {
  description = "Security Group Id ECS Client service"
  value       = aws_security_group.ecs_client_service.id
}
output "sg_client_alb_id" {
  description = "Security Group Id ECS Client ALB"
  value       = aws_security_group.client_alb.id
}
output "sg_acl_controller_id" {
  description = "Security Group Id for ACL Controller"
  value       = aws_security_group.acl_controller.id
}
