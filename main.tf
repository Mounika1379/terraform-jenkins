provider "aws" {
region = "ap-south-1"
access_key = "AKIA3OWTCUQACKQBTXYZ"
secret_key = "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"
}
resource "aws_instance" "one" {
  ami                   = "ami-0f8ca728008ff5af4"
  instance_type         = "t2.micro"
  key_name              = "mounika"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone     = "ap-south-1a"
  user_data             = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all thie is my website created by terraform infrastructure by server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "server-1"
  }
}
resource "aws_instance" "two" {
  ami                   = "ami-0f8ca728008ff5af4"
  instance_type         = "t2.micro"
  key_name              = "mounika"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone     = "ap-south-1b"
  user_data              + <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all thie is my website created by terraform infrastructure by server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "server-2"
  }
}
resource "aws_security_group" "three" {
  name = "elb-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
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
}
resource "aws_s3_bucket" "four" {
  bucket = "mounika123bucketterra"
}

