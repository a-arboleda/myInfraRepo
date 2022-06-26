provider "aws" {
  region = var.aws_region
}

#Create security group with firewall rules
resource "aws_security_group" "security_jenkins_port" {
  name        = "security_jenkins_port"
  description = "security group for jenkins"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = "security_jenkins_port"
  }
}

resource "aws_instance" "myFirstInstance" {
  ami           = "ami-0b9064170e32bde34"
  instance_type = var.instance_type
  security_groups= [ "security_jenkins_port"]
  tags= {
    Name = "jenkins_instance"
  }
}

# Create Elastic IP address
resource "aws_eip" "myFirstInstance" {
  vpc      = true
  instance = aws_instance.myFirstInstance.id
tags= {
    Name = "jenkins_elstic_ip"
  }
}

resource "aws_key_pair" "terraform-keys" {
  key_name = "terraform-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDuE1FiChqRrpP2WlBAcxTdQuHOeK82UdS+lo4eQKDQN6lVSVrBwOdwV2GFqosA35mHT511vZLtw9YDN5UcR9CCeOGHz5mRdr1lv8N6ujVs5q+ZUqXBNQcmW6so4eA2PlO78OoZCZKHVjapjeTLj0UZzjtg/IFHaBzTMDwhBr5OAeDwG0qqpOsmgYDOzwjamWjJyIhi/i+0LXUbHnJRdJ9jahrojb4DNuWJksL5/LTNsmzFeBZ3eWqJR/Rzzec4vOYZxOWOgOmRb1wLd1ckPIX38nZlSLqlM0pumIuXdaMnEjYGTjpX/bo+XR79PjngSWk4XSiLo7SPYn/y21VrPewi1m3fZHK7U5BFcxnXPO0yj2ec1jDjNuq94nRS9Yxn9J7qih8uSEzHWG5ZyZrgXzfM4KCd/w4LiBLYIAIJFTMTdlIAeKE80351cy9vRJJaw2CTXebcOsV9cjwgAcdb3aENmzSuqaDS9kX3IXYLxI8Ue5tb7OJGqDm515N5WTalv8= Alisson Arboleda@LAPTOP-AKPCG6D4"
}