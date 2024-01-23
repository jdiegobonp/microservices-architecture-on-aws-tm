// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

resource "tls_private_key" "ca_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}
resource "tls_self_signed_cert" "ca_cert" {
  allowed_uses = [
    "cert_signing",
    "key_encipherment",
    "digital_signature",
  ]
  is_ca_certificate     = true
  private_key_pem       = tls_private_key.ca_key.private_key_pem
  validity_period_hours = 8760
  subject {
    common_name  = "Consul Agent CA"
    organization = "HashiCorp Inc."
  }
}
resource "tls_private_key" "consul_server_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}
resource "tls_cert_request" "consul_server_cert" {
  dns_names = [
    "server.dc1.consul",
    "localhost",
  ]
  ip_addresses = [
    "10.0.48.250",
    "10.0.64.250",
    "10.0.80.250",
  ]
  private_key_pem = tls_private_key.consul_server_key.private_key_pem
  subject {
    common_name  = "server.dc1.consul"
    organization = "HashiCorp Inc."
  }
}
resource "tls_locally_signed_cert" "consul_server_signed_cert" {
  allowed_uses = [
    "digital_signature",
    "key_encipherment",
  ]
  ca_cert_pem           = tls_self_signed_cert.ca_cert.cert_pem
  ca_private_key_pem    = tls_private_key.ca_key.private_key_pem
  cert_request_pem      = tls_cert_request.consul_server_cert.cert_request_pem
  validity_period_hours = 8760
}
