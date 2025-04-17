resource "aws_lb" "alb" {
  name               = "lmvs-gcv-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group]
  subnets            = var.public_subnet_ids

  tags = {
    Name    = "lmvs-gcv-alb"
    Periodo = "8"
    Aluno   = "lmvs"
  }
}

resource "aws_lb_target_group" "tg" {
  name        = "lmvs-gcv-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  tags = {
    Name    = "lmvs-gcv-tg"
    Periodo = "8"
    Aluno   = "lmvs"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
