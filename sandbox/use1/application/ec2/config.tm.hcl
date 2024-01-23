globals {
  tfstate_base_path = "${global.environment}/${global.aws_account_id}/${global.region_code}/application"
  tfstate_bootstrap_base_path = "${global.environment}/${global.aws_account_id}/${global.region_code}/bootstrap"


}