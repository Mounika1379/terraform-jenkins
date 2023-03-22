resource "aws_elb" "bal" {
  name              = "mounika-terraform-elb"
  availability_zone = ["ap-south-1a", "ap-south-1b"]
  listener {
    instance_port     = 80
    instance_protocal = "httpd"
    lb_port           = 80
    lb_protocal       = "httpd"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    target              = "http:80/"
    interval            = 30
  }
  instance                  = ["${aws_instance.one.id}", "${aws_instance.two.id}"]
  cross_zone_load_balancing = true
  idle_timeout              = 400
  tags = {
    Name = "mounika-terraform-elb"
  }
}
