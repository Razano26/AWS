module "ec2" {
  source = "./modules/1-EC2"
  ec2_instances = var.ec2_instances
}

module "sns" {
  source = "./modules/2-SNS"
  sns_topic_name = var.sns_topic
  email_subscribers = var.email_subscribers
  lambda_function_name = var.lambda_function_name
  lambda_role_arn = var.lambda_role_arn
}

module "cloudwatch" {
  source = "./modules/3-CloudWatch"
  function_name = module.sns.lambda_function_name
  function_arn = module.sns.lambda_function_arn
}