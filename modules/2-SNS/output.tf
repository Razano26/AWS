output "sns_topic_arn" {
  description = "value of the SNS topic ARN"
  value = aws_sns_topic.sns_topic.arn 
}