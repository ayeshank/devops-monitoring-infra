resource "aws_route_table" "ank_public_rt" {
  vpc_id = aws_vpc.ank_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ank_igw.id
  }
  tags = {
    Name = "ANKPublicRouteTable"
  }
}
resource "aws_route_table_association" "public_association" {
  count          = 3
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.ank_public_rt.id
}



resource "aws_route_table" "ank_private_rt" {
  vpc_id = aws_vpc.ank_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[0].id
  }
  tags = {
    Name = "ANKPrivateRouteTable"
  }
}
resource "aws_route_table_association" "private_association" {
  count          = 3
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.ank_private_rt.id
}
