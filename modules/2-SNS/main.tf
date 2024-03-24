resource "aws_sns_topic" "sns_topic" {
  name = var.sns_topic_name
}

// Abonnement des emails à la file SNS
resource "aws_sns_topic_subscription" "email_subscription" {
  for_each = toset(var.email_subscribers)
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = each.value
  endpoint_auto_confirms = true
}

resource "aws_lambda_function" "lambda_function" {
  function_name = var.lambda_function_name
  handler = "index.handler"
  runtime = "nodejs20.x"
  role = var.lambda_role_arn
  filename = "./modules/2-SNS/lambda_func.zip"
  source_code_hash = filebase64sha256("./modules/2-SNS/lambda_func.zip")

  environment {
    variables = {
      LAMBDA_ARN     = aws_sns_topic.sns_topic.arn
      LAMBDA_MESSAGE = var.sended_notification
    }
  }
}