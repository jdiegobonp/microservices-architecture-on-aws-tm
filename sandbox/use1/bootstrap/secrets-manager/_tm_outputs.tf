// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

output "ssm_consul_root_ca_cert_arn" {
  description = "SSM arn for root ca cert."
  sensitive   = true
  value       = aws_secretsmanager_secret.consul_root_ca_cert.arn
}
output "ssm_consul_bootstrap_token_arn" {
  description = "SSM arn for the consult bootstrap token."
  sensitive   = true
  value       = aws_secretsmanager_secret.consul_bootstrap_token.arn
}
output "ssm_consul_gossip_key_arn" {
  description = "SSM arn for the gossip key."
  sensitive   = true
  value       = aws_secretsmanager_secret.consul_gossip_key.arn
}
