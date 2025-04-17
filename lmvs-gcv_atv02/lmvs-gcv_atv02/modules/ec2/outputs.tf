output "asg_target_group" {
  description = "ARN do Target Group associado ao Auto Scaling Group"
  value       = aws_autoscaling_group.asg.target_group_arns
}
