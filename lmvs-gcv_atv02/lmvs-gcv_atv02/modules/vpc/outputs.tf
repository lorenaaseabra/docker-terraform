output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs das Subnets públicas criadas"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  description = "IDs das Subnets privadas criadas"
  value       = [for subnet in aws_subnet.private : subnet.id]
}
