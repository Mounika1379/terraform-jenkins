provider "aws" {
region = "ap-south-1"
}

resource "aws_instance" "one" {
  ami                   = "ami-005f9685cb30f234b"
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
  ami                   = "ami-005f9685cb30f234b"
  instance_type         = "t2.micro"
  key_name              = "mounika"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone     = "ap-south-1c"
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
