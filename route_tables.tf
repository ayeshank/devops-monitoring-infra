# Create a Route Table
resource "aws_route_table" "public-rt-igw" {
  vpc_id = aws_vpc.ank_vpc.id
  tags = {
    Name = "public-rt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ank_igw.id
  }
}

resource "aws_route_table" "private-rt-nat" {
  vpc_id = aws_vpc.ank_vpc.id
  tags = {
    Name = "private-rt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw-1.id
  }
}


# Route Table Association
resource "aws_route_table_association" "public-rt-as-1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public-rt-igw.id
}

resource "aws_route_table_association" "public-rt-as-2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public-rt-igw.id
}

resource "aws_route_table_association" "public-rt-as-3" {
  subnet_id      = aws_subnet.public_subnet_3.id
  route_table_id = aws_route_table.public-rt-igw.id
}
resource "aws_route_table_association" "private-rt-as-4" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private-rt-nat.id
}

resource "aws_route_table_association" "private-rt-as-5" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private-rt-nat.id
}
resource "aws_route_table_association" "public-rt-as-6" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.private-rt-nat.id
}

