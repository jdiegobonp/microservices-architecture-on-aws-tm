// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name = "group-name"
    values = [
      "us-east-1",
    ]
  }
}
