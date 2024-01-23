// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

resource "random_id" "consul_gossip_key" {
  byte_length = 32
}
resource "random_uuid" "consul_bootstrap_token" {
}
resource "aws_secretsmanager_secret" "consul_gossip_key" {
  name_prefix = "jadegproj-gossip-key-"
}
resource "aws_secretsmanager_secret_version" "consul_gossip_key" {
  secret_id     = aws_secretsmanager_secret.consul_gossip_key.id
  secret_string = random_id.consul_gossip_key.b64_std
}
resource "aws_secretsmanager_secret" "consul_bootstrap_token" {
  name_prefix = "jadegproj-bootstrap-token-"
}
resource "aws_secretsmanager_secret_version" "consul_bootstrap_token" {
  secret_id     = aws_secretsmanager_secret.consul_bootstrap_token.id
  secret_string = random_uuid.consul_bootstrap_token.id
}
resource "aws_secretsmanager_secret" "consul_root_ca_cert" {
  name_prefix = "jadegproj-root-ca-cert-"
}
resource "aws_secretsmanager_secret_version" "consul_root_ca_cert" {
  secret_id     = aws_secretsmanager_secret.consul_root_ca_cert.id
  secret_string = data.terraform_remote_state.tls.outputs.tls_self_signed_cert_pem
}
