output "instance_ids" {
  value = [for instance in aws_instance.ec2_instance: instance.id]
  description = "Ids of the EC2 instances"
}