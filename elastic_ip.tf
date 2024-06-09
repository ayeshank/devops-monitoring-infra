resource "aws_eip" "frontend_eip" {
  instance = aws_instance.ec2_ubuntu_instance_1.id
}
# Associate Elastic IP with EC2 instance
resource "aws_eip_association" "frontend_eip_assoc" {
  instance_id   = aws_instance.ec2_ubuntu_instance_1.id
  allocation_id = aws_eip.frontend_eip.id
}

resource "aws_eip" "backend_eip" {
  instance = aws_instance.ec2_ubuntu_instance_2.id
}
resource "aws_eip_association" "backend_eip_assoc" {
  instance_id   = aws_instance.ec2_ubuntu_instance_2.id
  allocation_id = aws_eip.backend_eip.id
}


resource "aws_eip" "bi_eip" {
  instance = aws_instance.ec2_ubuntu_instance_3.id
}
resource "aws_eip_association" "bi_eip_assoc" {
  instance_id   = aws_instance.ec2_ubuntu_instance_3.id
  allocation_id = aws_eip.bi_eip.id
}
