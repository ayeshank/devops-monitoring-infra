# resource "aws_lb" "app_lb" {
#   name               = "app-lb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.lb_sg.id]
#   subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

#   enable_deletion_protection = false

#   tags = {
#     Name = "app-lb"
#   }
# }

# resource "aws_lb_target_group" "frontend_tg" {
#   name     = "frontend-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.ank_vpc.id

#   health_check {
#     path                = "/"
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 5
#     unhealthy_threshold = 2
#     matcher             = "200"
#   }

#   tags = {
#     Name = "frontend-tg"
#   }
# }

# resource "aws_lb_target_group" "backend_tg" {
#   name     = "backend-tg"
#   port     = 5000
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.ank_vpc.id

#   health_check {
#     path                = "/health"
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 5
#     unhealthy_threshold = 2
#     matcher             = "200"
#   }

#   tags = {
#     Name = "backend-tg"
#   }
# }

# resource "aws_lb_target_group_attachment" "frontend_tg_attachment" {
#   target_group_arn = aws_lb_target_group.frontend_tg.arn
#   target_id        = aws_instance.ec2_ubuntu_instance_1.id
#   port             = 80
# }

# resource "aws_lb_target_group_attachment" "backend_tg_attachment" {
#   target_group_arn = aws_lb_target_group.backend_tg.arn
#   target_id        = aws_instance.ec2_ubuntu_instance_2.id
#   port             = 5000
# }

# resource "aws_lb_listener" "http_listener" {
#   load_balancer_arn = aws_lb.app_lb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.frontend_tg.arn
#   }
# }

# resource "aws_lb_listener" "https_listener" {
#   load_balancer_arn = aws_lb.app_lb.arn
#   port              = "443"
#   protocol          = "HTTPS"

#   ssl_policy      = "ELBSecurityPolicy-2016-08"
#   certificate_arn = "arn:aws:acm:us-east-1:730026389710:certificate/9b000eab-9034-4202-bb0f-b7b6013c789c" # Replace with your ACM certificate ARN

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.frontend_tg.arn
#   }
# }



resource "aws_lb" "app_lb_new" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id, aws_subnet.public_subnet_3.id]
}

resource "aws_lb_target_group" "app-tg" {
  name     = "app-tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = aws_vpc.ank_vpc.id
}

resource "aws_lb_listener" "app-listener" {
  load_balancer_arn = aws_lb.app_lb_new.arn
  port              = "443"
  protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-tg.arn
  }
}

resource "aws_lb_target_group_attachment" "frontend" {
  target_group_arn = aws_lb_target_group.app-tg.arn
  target_id        = aws_instance.ec2_ubuntu_instance_1.id
  port             = 443
}

resource "aws_lb_target_group_attachment" "backend" {
  target_group_arn = aws_lb_target_group.app-tg.arn
  target_id        = aws_instance.ec2_ubuntu_instance_2.id
  port             = 443
}
