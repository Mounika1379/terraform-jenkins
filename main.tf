provider "aws" {
region = "us-east-1"
access_key = "AKIA3OWTCUQAOSEAP5PZ"
secret_key = "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"
}
resource "aws _instance" "one" {
ami = "ami-005f9685cb30f234b"
instance_type = "t2.micro"
key_name = "mounika"
vpc_security_group_id = [aws_security_group.three.id]
availability_zone = "us-east-1a"
user_data = <<EOF
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
resorce "aws_instance" "two" {
ami = "ami-005f9685cb30f234b"
instance_type = "t2.micro"
key_name = "mounika"
vpc_security_group_id = [aws_security_group.three.id]
availability_zone = "us-east-1b"
user_data = <<EOF
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
from_port = 22
to_port = 22
protocal = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
ingress {
from_port = 80
to_port = 80
protocal = "tcp"
cidr_blocks= ["0.0.0.0/0"]
}
egress {
from_port = 0
to_port = 0
protocal = "-i"
cidr_blocks = ["0.0.0.0/0"]
}
}

[root@ip-172-31-11-141 ~]# terraform fmt
main.tf
[root@ip-172-31-11-141 ~]# cat main.tf
provider "aws" {
  region = "us-east-1"
}

resource "aws _instance" "one" {
  ami                   = "ami-005f9685cb30f234b"
  instance_type         = "t2.micro"
  key_name              = "mounika"
  vpc_security_group_id = [aws_security_group.three.id]
  availability_zone     = "us-east-1a"
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
resorce "aws_instance" "two" {
  ami                   = "ami-005f9685cb30f234b"
  instance_type         = "t2.micro"
  key_name              = "mounika"
  vpc_security_group_id = [aws_security_group.three.id]
  availability_zone     = "us-east-1b"
  user_data             = <<EOF
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
    protocal    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocal    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocal    = "-i"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
