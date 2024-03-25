resource "aws_instance" "ec2_instance" {
  for_each = { for ec2 in var.ec2_instances : ec2.name => ec2 }

  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = try(each.value.instance_type, "t3.nano")
  user_data     = try(each.value.user_data, null)
  tags = {
    Name = each.value.name
  }

  iam_instance_profile = try(each.value.instance_role_name, null)
}
