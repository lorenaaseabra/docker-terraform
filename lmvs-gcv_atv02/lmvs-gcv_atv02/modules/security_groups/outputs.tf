output "public_ec2_sg" {
  description = "ID do Security Group para a instância EC2 pública"
  value       = aws_security_group.public_ec2.id
}

output "private_ec2_sg" {
  description = "ID do Security Group para a instância EC2 privada"
  value       = aws_security_group.private_ec2.id
}

output "rds_sg" {
  description = "ID do Security Group para o RDS"
  value       = aws_security_group.rds.id
}

output "alb_sg" {
  description = "ID do Security Group para o ALB"
  value       = aws_security_group.alb.id
}
