variable "sns_topic_name" {
  description = "The name of the SNS topic"
  type        = string
}

variable "email_subscribers" {
  description = "List of email addresses to subscribe to the SNS topic"
  type        = list(string)
}

variable "lambda_function_name" {
  description = "The name of the lambda function"
  type        = string
}

variable "lambda_role_arn" {
  description = "The ARN of the IAM role to attach to the lambda function"
  type        = string
}
