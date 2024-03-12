# Fichier : variables.tf

variable "instance_name" {
  description = "Nom de l'instance EC2"
  default = "DefaultInstanceName"
}

variable "instance_type" {
  description = "Type de l'instance EC2"
  default     = "t3.nano"
}

variable "user_data" {
  description = "Données utilisateur pour l'instance EC2 (optionnel)"
  default     = ""
}
