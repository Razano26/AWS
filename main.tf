module "ec2" {
  source = "./modules/1-EC2"
}

module "module2" {
  source = "./modules/2-SNS"
  sns_topic_name = var.sns_topic
  email_subscribers = var.email_subscribers
  lambda_function_name = var.lambda_function_name
  lambda_role_arn = var.lambda_role_arn
}
