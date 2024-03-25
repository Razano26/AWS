resource "aws_cloudwatch_event_rule" "ec2_state_change" {
  name        = "ec2-instance-state-change"
  description = "Capture EC2 Instance State Changes to Running"

  event_pattern = jsonencode({
    "source" : ["aws.ec2"],
    "detail-type" : ["EC2 Instance State-change Notification"],
    "detail" : {
      "state" : ["running"]
    }
  })
}

resource "aws_cloudwatch_event_target" "invoke_lambda" {
  rule      = aws_cloudwatch_event_rule.ec2_state_change.name
  arn       = var.function_arn
  target_id = "invoke-lambda"
  input_transformer {
    input_paths = {
      instance-id = "$.detail.instance-id"
    }
    input_template = "\"{\\\"instance_id\\\":\\\"<instance-id>\\\"}\""
  }
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2_state_change.arn
}
