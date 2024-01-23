globals {

  environment = "dev"
  aws_account_id = "000000000000"
  tfstate_base_path = "${global.environment}/${global.aws_account_id}/microservices"
  tfstate_file = "terraform.tfstate"
  tfstate_bucket_region = "us-east-1"
  tfstate_dynamodb_table_lock = "miniproj-tflock-${global.environment}"
  tfstate_iam_role_arn = {
    "sandbox" = "arn:aws:iam::${global.aws_account_id}:role/terraform-role"
  }
  tfstate_bucket_name = {
    sandbox = "miniproj-tfstate-${global.environment}"
  }
  default_region = "us-east-1"
  region_code = "use1"
  vpc_cidr = "10.0.0.0/16"
  project_tag = "microproj"
  public_cidr_blocks  = [for i in tm_range(global.public_subnet_count) : tm_cidrsubnet(global.vpc_cidr, 4, i)]
  private_cidr_blocks = [for i in tm_range(global.private_subnet_count) : tm_cidrsubnet(global.vpc_cidr, 4, i + global.public_subnet_count)]
  server_private_ips  = [for i in global.private_cidr_blocks : tm_cidrhost(i, 250)]
  ec2_key_pair = "miniprojkp"
  database_private_ip = tm_cidrhost(global.private_cidr_blocks[0],10)
  database_service_name = "database"
  database_message = "Hello from the database"
  public_subnet_count = 3
  private_subnet_count = 3
  consul_dc1_name = "dc1"
  consul_server_allowed_cidr_blocks = ["0.0.0.0/0"]
  consul_server_count = 1
}