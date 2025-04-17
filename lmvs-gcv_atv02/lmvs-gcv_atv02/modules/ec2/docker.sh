#!/bin/bash
yum update -y
amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ec2-user

docker run -d -p 80:3000 vnvzz/getting-started:latest