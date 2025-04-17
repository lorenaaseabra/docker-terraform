variable "vpc_id" {
  description = "ID da VPC onde o ALB será criado"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs das subnets públicas onde o ALB será criado"
  type        = list(string)
}


variable "security_group" {
  description = "ID do Security Group associado ao ALB"
  type        = string
}