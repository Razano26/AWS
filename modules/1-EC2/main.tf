# Définition du module
resource "aws_instance" "ec2_instance" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = var.instance_type
  user_data     = var.user_data
  tags = {
    Name = var.instance_name
  }
}
