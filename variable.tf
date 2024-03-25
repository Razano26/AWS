variable "sns_topic" {
  description = "The name of the SNS topic"
  type        = string
  default     = "ec2-starting"
}

variable "email_subscribers" {
  description = "List of email addresses to subscribe to the SNS topic"
  type        = list(string)
  default     = ["labeyrielouis@gmail.com"]
}

variable "lambda_function_name" {
  description = "The name of the lambda function"
  type        = string
  default     = "send_mail"
}

variable "lambda_role_arn" {
  description = "The ARN of the IAM role to attach to the lambda function"
  type        = string
  default     = "arn:aws:iam::637423481982:role/Lamda_role"
}

variable "ec2_instances" {
  description = "A list of EC2 instances to create"
  type = list(object({
    name               = string
    instance_type      = optional(string, "t3.nano")
    user_data          = optional(string, null)
    instance_role_name = optional(string, null)
  }))
  default = []
}

