resource "aws_launch_template" "Launch-template" {
  name_prefix   = "launch-template"
  image_id      = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "bar" {
  availability_zones = ["us-east-1a", "us-east-1b"]
  desired_capacity   = 4
  max_size           = 2
  min_size           = 2

  launch_template {
    id      = aws_launch_template.Launch-template.id
    version = "$Latest"
  }
}