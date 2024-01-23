generate_hcl "_tm_outputs.tf" {
  content {
    
    output "ec2_consul_servers" {
      description = "EC2 consul servers ids"
      value       = aws_instance.consul_server.*.id
    }

  }
}