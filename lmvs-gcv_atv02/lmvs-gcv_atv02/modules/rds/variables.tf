variable "vpc_id" {
  description = "ID da VPC onde o RDS será criado"
  type        = string
}

variable "private_subnets" {
  description = "IDs das Subnets privadas onde o RDS será criado"
  type        = list(string)
}

variable "security_group" {
  description = "ID do Security Group associado ao RDS"
  type        = string
}
