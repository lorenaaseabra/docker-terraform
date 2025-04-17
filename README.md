# 🚀 Docker + Terraform – Getting Started App Deployment on AWS

## 📌 Overview

This project is part of a practical exercise using **Infrastructure as Code (IaC)** to deploy a scalable environment on AWS, replacing traditional EC2-based web application deployment with **Docker-based containers** running on EC2 instances managed via an **Auto Scaling Group** and behind an **Application Load Balancer (ALB)**.

The application deployed is the official [Docker Getting Started App](https://github.com/docker/getting-started/tree/master/app), which allows users to interact with a simple web UI to create a to-do list.

---

## 🧱 Infrastructure Architecture

All provisioning is done using **Terraform**, and each AWS component is organized into its own module:

### ✅ VPC
- CIDR Block: `172.31.0.0/16`
- Subnets:
  - `172.31.1.0/24` (Public)
  - `172.31.2.0/24` (Public)
  - `172.31.3.0/24` (Private)
  - `172.31.4.0/24` (Private)

### ✅ Security Groups
- EC2 Public: allows HTTP (`port 80`) from `0.0.0.0/0`
- EC2 Private: allows HTTP (`port 80`) from the Public EC2 SG
- RDS: allows MySQL (`port 3306`) from the Private EC2 SG
- ALB: allows HTTP (`port 80`) from `0.0.0.0/0`

### ✅ Auto Scaling Group (ASG)
- Min: 1 instance / Max: 2 instances (`t2.micro`)
- Uses **Amazon Linux 2**
- Executes a startup script to:
  - Install Docker
  - Pull and run the app container from Docker Hub
  - Map container port `3000` to host port `80`

### ✅ Application Load Balancer (ALB)
- Internet-facing
- Port 80 open
- Routes traffic to EC2 instances in ASG

### ✅ RDS
- MySQL instance (`t3.micro`)
- No public access
- 7-day backup retention

---

## 🐳 Application Containerization

### Dockerfile

```Dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "run", "dev"]
```
## 🧩 Terraform Modules

Each infrastructure component is a separate Terraform module.

### Example – `main.tf` (inside EC2 module):

```hcl
resource "aws_launch_template" "ec2_template" {
  name_prefix   = "lmvs-gcv-ec2-template"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  user_data = filebase64("${path.module}/docker.sh")
}
```

## Docker.sh
```
#!/bin/bash
yum update -y
amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ec2-user
docker run -d -p 80:3000 gabrieldcv/getting-started:latest
```

## 🧹 Cleanup

After testing, remove all resources using:

```bash
terraform destroy
```
Or stop all EC2 instances and clean up the environment manually.
⚠️ Do not leave any resources running overnight to avoid AWS charges.

## 🧪 How to Run Locally

```bash
git clone https://github.com/lorenaaseabra/docker-terraform.git
cd docker/app
docker build -t getting-started .
docker run -dp 3000:3000 getting-started
```

## n👥 Team
Lorena Seabra
Gabriel Dantas
