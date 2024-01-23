generate_hcl "_tm_outputs.tf" {
  content {
    
    output "consul_instance_profile_name" {
      description = "Name for the consul instance profile"
      value       = "${global.project_tag}-instance-profile"
    }

  }
}