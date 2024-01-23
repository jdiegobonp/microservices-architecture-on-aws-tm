// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

output "tls_self_signed_cert_pem" {
  description = "tls self signed cert pem"
  sensitive   = true
  value       = tls_self_signed_cert.ca_cert.cert_pem
}
output "tls_locally_signed_cert_pem" {
  description = "tls locally signed cert pem"
  sensitive   = true
  value       = tls_locally_signed_cert.consul_server_signed_cert.cert_pem
}
output "tls_private_key_pem" {
  description = "tls private key pem"
  sensitive   = true
  value       = tls_private_key.consul_server_key.private_key_pem
}
