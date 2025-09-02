provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "monitoring_sg" {
  name        = "monitoring-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "monitoring" {
  ami = "ami-04aa00acb1165b32a"
    instance_type = "t2.micro"
    key_name = "MyOwnLinKey"

  security_groups = [aws_security_group.monitoring_sg.name]

  user_data = file("user_data.sh")

  tags = {
    Name = "MonitoringInstance"
  }
}