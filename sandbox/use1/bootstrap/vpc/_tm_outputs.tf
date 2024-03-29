// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}
output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = aws_vpc.main.arn
}
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private[*].id
}
output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = aws_subnet.private[*].arn
}
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public[*].id
}
output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.public[*].arn
}
