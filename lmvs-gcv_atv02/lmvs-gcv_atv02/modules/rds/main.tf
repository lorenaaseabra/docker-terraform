resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "lmvs-gcv-rds-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name    = "lmvs-gcv-rds-subnet-group"
    Periodo = "8"
    Aluno   = "lmvs"
  }
}

resource "aws_db_instance" "rds" {
  identifier              = "lmvs-gcv-rds"
  engine                  = "mysql"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = "admin"
  password                = "password123"
  publicly_accessible     = false
  vpc_security_group_ids  = [var.security_group]
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  backup_retention_period = 7

  tags = {
    Name    = "lmvs-gcv-rds"
    Periodo = "8"
    Aluno   = "lmvs"
  }
}