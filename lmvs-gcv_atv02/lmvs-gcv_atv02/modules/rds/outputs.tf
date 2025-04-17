output "rds_endpoint" {
  description = "Endpoint do banco de dados RDS"
  value       = aws_db_instance.rds.endpoint
}

output "rds_arn" {
  description = "ARN do banco de dados RDS"
  value       = aws_db_instance.rds.arn
}
