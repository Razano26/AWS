# Fichier : outputs.tf

# Output pour retourner l'ID de l'instance EC2
output "instance_id" {
  description = "ID de l'instance EC2"
  value       = aws_instance.ec2_instance.id
}
