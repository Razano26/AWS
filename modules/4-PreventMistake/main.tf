resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid = ""
      },
    ]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.lambda_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "cloudwatch:PutMetricData",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
        Effect = "Allow"
      },
    ]
  })
}

resource "aws_lambda_function" "lambda_function" {
  function_name = "my_ec2_watcher_lambda"

  filename      = "${path.module}/lambda_func.zip"
  handler       = "index.handler"
  runtime       = "nodejs20.x"
  role          = aws_iam_role.lambda_execution_role.arn

  source_code_hash = filebase64sha256("${path.module}/lambda_func.zip")
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2_launch_rule.arn
}

resource "aws_cloudwatch_event_rule" "ec2_launch_rule" {
  name        = "my_ec2_launch_rule"
  description = "Triggers on EC2 launch"

  event_pattern = jsonencode({
    source: ["aws.ec2"],
    "detail-type": ["EC2 Instance State-change Notification"],
    detail: { state: ["running"] }
  })
}

resource "aws_cloudwatch_event_target" "event_target" {
  rule      = aws_cloudwatch_event_rule.ec2_launch_rule.name
  arn       = aws_lambda_function.lambda_function.arn
}

resource "aws_cloudwatch_metric_alarm" "too_many_instances" {
  alarm_name          = "too_many_ec2_instances"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "InstancesLaunched"
  namespace           = "EC2"
  period              = 30
  statistic           = "Sum"
  threshold           = 2
  alarm_description   = "This alarm fires if more than 2 instances are launched within 30 seconds"
  datapoints_to_alarm = 1

  alarm_actions = [
    aws_sns_topic.too_many_ec2.arn
  ]
}

resource "aws_sns_topic" "too_many_ec2" {
  name = "too_many_ec2"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.too_many_ec2.arn
  protocol  = "email"
  endpoint  = "labeyrielouis@gmail.com"
}