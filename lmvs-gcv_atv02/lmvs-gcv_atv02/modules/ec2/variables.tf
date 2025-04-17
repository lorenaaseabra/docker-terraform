variable "vpc_id" {
  description = "ID da VPC onde o Auto Scaling Group será criado"
  type        = string
}

variable "public_subnet_id" {
  description = "ID da Subnet pública onde as instâncias EC2 serão criadas"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs das Subnets privadas (não utilizadas diretamente neste módulo)"
  type        = list(string)
}

variable "security_groups" {
  description = "Security Groups para as instâncias EC2"
  type = object({
    public_ec2_sg  = string
    private_ec2_sg = string
  })
}

variable "asg_target_group" {
  description = "ARN do Target Group associado ao Auto Scaling Group"
  type        = string
}

variable "tags" {
  description = "Tags para os recursos criados"
  type        = map(string)
  default     = {}
}
