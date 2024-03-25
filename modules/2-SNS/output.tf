output "sns_topic_arn" {
  description = "value of the SNS topic ARN"
  value = aws_sns_topic.sns_topic.arn 
}

output "lambda_function_name" {
  description = "value of the lambda function name"
  value = aws_lambda_function.lambda_function.function_name
}

output "lambda_function_arn" {
  description = "value of the lambda function ARN"
  value = aws_lambda_function.lambda_function.arn
}