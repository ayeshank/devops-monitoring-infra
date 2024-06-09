# MySQL RDS instance
resource "aws_db_instance" "mysql_instance" {
  identifier             = "mysql-instance"
  engine                 = "mysql"
  engine_version         = "8.0.35"
  instance_class         = "db.t3.micro"
  publicly_accessible    = true
  allocated_storage      = 10
  storage_type           = "gp2"
  username               = "ayesha"
  password               = "757001Ankk"
  db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  skip_final_snapshot = true

  tags = {
    Name = "Ayesha MySQL Instance"
  }
}

output "db_instance_endpoint" {
  value = aws_db_instance.mysql_instance.endpoint
}

output "db_instance_username" {
  value = aws_db_instance.mysql_instance.username
}

resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my_db_subnet_group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id, aws_subnet.private_subnet_3.id]

  tags = {
    Name = "ANKDBSubnetGroup"
  }
}
