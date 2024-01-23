generate_hcl "_tm_data.tf" {

  content {
    data "aws_availability_zones" "available" {
      state = "available"
      filter {
        name   = "group-name"
        values = [global.default_region]
      }
    }
  }
 }


    