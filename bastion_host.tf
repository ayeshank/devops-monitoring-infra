resource "aws_instance" "bastion_host" {
  ami             = "ami-080e1f13689e07408" # Ubuntu 20.04 AMI ID (or another AMI ID suitable for your region)
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public_subnet_1.id # Change this to your public subnet
  key_name        = "ayesha-terraform"
  security_groups = [aws_security_group.bastion_sg.id]
  tags = {
    Name = "Bastion Host"
  }
}
resource "aws_security_group" "bastion_sg" {
  vpc_id = aws_vpc.ank_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["YOUR_IP_ADDRESS/32"] # Replace with your IP address
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "BastionSG"
  }
}
