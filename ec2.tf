resource "aws_instance" "ubuntu_web_server_instance" {
  count           = 3
  ami             = "ami-080e1f13689e07408"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public_subnet[count.index].id
  key_name        = "ayesha-terraform"
  security_groups = [aws_security_group.web_server_sg.id] # Assign Ubuntu security group
  tags = {
    Name = "ANKWebServer-${count.index}"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  user_data = templatefile("${path.module}/ec2_userdata/ubuntu_userdata.sh", {})
}
