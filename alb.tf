resource "aws_lb_target_group" "alb-target-group" {
  name     = "application-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    enabled = true
    healthy_threshold = 3
    interval = 10
    matcher = 200
    path = "/"
    port = "traffic-port"
    protocol = "http"
    timeout = 6
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group_attachment" "attach-server10" {
  target_group_arn = aws_lb_target_group.alb-target-group.arn
  target_id        = aws_instance.server10.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach-server20" {
  target_group_arn = aws_lb_target_group.alb-target-group.arn
  target_id        = aws_instance.server20.id
  port             = 80
}



resource "aws_lb_listener" "alb-http-listener" {
  load_balancer_arn = aws_lb.application-lb.arn
  port              = "443"
  protocol          = "HTTPS"
 
 

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-target-group.arn
  }
}

resource "aws_lb" "application-lb" {
  name               = "application-lb"
  internal           = false
  load_balancer_type = "application"

  subnets            = [aws_subnet.public_subnet_az1.id, aws_subnet.public_subnet_az2.id, aws_subnet.public_subnet_az3.id]

  enable_deletion_protection = true

  tags = {
    Environment = "application-lb"
    Name ="application-lb"
  }
}
