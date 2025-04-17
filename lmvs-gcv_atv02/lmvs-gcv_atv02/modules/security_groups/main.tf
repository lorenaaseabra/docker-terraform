resource "aws_security_group" "public_ec2" {
  name        = "lmvs-gcv-public-ec2-sg"
  description = "Allow HTTP traffic from anywhere"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "lmvs-gcv-public-ec2-sg"
    Periodo = "8"
    Aluno   = "lmvs"
  }
}

resource "aws_security_group" "private_ec2" {
  name        = "lmvs-gcv-private-ec2-sg"
  description = "Allow HTTP traffic from public EC2 SG"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public_ec2.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "lmvs-gcv-private-ec2-sg"
    Periodo = "8"
    Aluno   = "lmvs"
  }
}

resource "aws_security_group" "rds" {
  name        = "lmvs-gcv-rds-sg"
  description = "Allow MySQL traffic from private EC2 SG"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.private_ec2.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "lmvs-gcv-rds-sg"
    Periodo = "8"
    Aluno   = "lmvs"
  }
}

resource "aws_security_group" "alb" {
  name        = "lmvs-gcv-alb-sg"
  description = "Allow HTTP traffic from anywhere"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "lmvs-gcv-alb-sg"
    Periodo = "8"
    Aluno   = "lmvs"
  }
}