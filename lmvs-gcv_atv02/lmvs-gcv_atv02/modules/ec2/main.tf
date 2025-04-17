resource "aws_launch_template" "ec2_template" {
  name_prefix   = "lmvs-gcv-ec2-template"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  user_data = filebase64("${path.module}/docker.sh")

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.security_groups.public_ec2_sg]
  }

  tags = {
    Name    = "lmvs-gcv-ec2-template"
    Periodo = "8"
    Aluno   = "lmvs"
  }
}


resource "aws_autoscaling_group" "asg" {
  launch_template {
    id      = aws_launch_template.ec2_template.id
    version = "$Latest"
  }

  vpc_zone_identifier = [var.public_subnet_id]
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1

  target_group_arns = [var.asg_target_group]
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
