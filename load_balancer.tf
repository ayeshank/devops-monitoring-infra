# resource "aws_lb" "my_alb" {
#   name               = "my-application-lb"
#   internal           = false # Set to true if you want the LB to be only accessible within the VPC
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.lb_sg.id]
#   subnets            = aws_subnet.public_subnet.*.id # Assuming you want the ALB accessible from the internet

#   tags = {
#     Name = "my-application-lb"
#   }
# }

# resource "aws_lb_target_group" "tg" {
#   name     = "my-target-group"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.ank_vpc.id

#   health_check {
#     enabled             = true
#     healthy_threshold   = 3
#     unhealthy_threshold = 3
#     timeout             = 5
#     path                = "/"
#     protocol            = "HTTP"
#     interval            = 30
#     matcher             = "200"
#   }
# }

# resource "aws_lb_listener" "front_end" {
#   load_balancer_arn = aws_lb.my_alb.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.tg.arn
#   }
# }

# resource "aws_lb_listener" "secure_front_end" {
#   load_balancer_arn = aws_lb.my_alb.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "arn:aws:acm:region:account-id:certificate/certificate-id" # Replace with your certificate ARN

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.tg.arn
#   }
# }
