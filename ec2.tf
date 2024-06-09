resource "aws_instance" "ec2_ubuntu_instance_1" {
  ami             = "ami-080e1f13689e07408" # Ubuntu 20.04 AMI ID
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.private_subnet_1.id
  key_name        = "ayesha-terraform"
  security_groups = [aws_security_group.web_server_sg.id]
  tags = {
    Name = "Ayesha ec2 ubuntu instance 1"
  }
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }
  user_data = templatefile("${path.module}/ec2_userdata/ubuntu_userdata.sh", {})
}

resource "aws_instance" "ec2_ubuntu_instance_2" {
  ami             = "ami-080e1f13689e07408" # Ubuntu 20.04 AMI ID
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.private_subnet_2.id
  key_name        = "ayesha-terraform"
  security_groups = [aws_security_group.web_server_sg.id]
  tags = {
    Name = "Ayesha ec2 ubuntu instance 2"
  }
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }
  user_data = templatefile("${path.module}/ec2_userdata/ubuntu_userdata.sh", {})
}

resource "aws_instance" "ec2_ubuntu_instance_3" {
  ami             = "ami-080e1f13689e07408" # Ubuntu 20.04 AMI ID
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.private_subnet_3.id
  key_name        = "ayesha-terraform"
  security_groups = [aws_security_group.web_server_sg.id]
  tags = {
    Name = "Ayesha ec2 ubuntu instance 3"
  }
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }
  user_data = templatefile("${path.module}/ec2_userdata/ubuntu_userdata.sh", {})
}

