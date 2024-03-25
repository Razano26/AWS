variable "ec2_instances" {
  description = "A list of EC2 instances to create"
  type = list(object({
    name                = string
    instance_type       = optional(string, "t3.nano")
    user_data           = optional(string, null)
    instance_role_name  = optional(string, null)
   }))
  default = []
}
