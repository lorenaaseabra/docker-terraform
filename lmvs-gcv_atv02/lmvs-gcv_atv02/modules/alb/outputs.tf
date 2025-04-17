output "alb_target_group" {
  description = "ARN do Target Group associado ao ALB"
  value       = aws_lb_target_group.tg.arn
}

output "alb_dns_name" {
  description = "DNS do Application Load Balancer"
  value       = aws_lb.alb.dns_name
}
