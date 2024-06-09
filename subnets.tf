data "aws_availability_zones" "available" {
  state = "available" # Fetches only zones that are currently available for use
}

#Public Subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.ank_vpc.id
  cidr_block              = "192.168.0.0/19"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "PublicSubnet-1"
  }
}
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.ank_vpc.id
  cidr_block              = "192.168.32.0/19"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "PublicSubnet-2"
  }
}
resource "aws_subnet" "public_subnet_3" {
  vpc_id                  = aws_vpc.ank_vpc.id
  cidr_block              = "192.168.64.0/19"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"
  tags = {
    Name = "PublicSubnet-3"
  }
}

# Private Subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.ank_vpc.id
  cidr_block              = "192.168.96.0/19"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "PrivateSubnet-1"
  }
}
resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.ank_vpc.id
  cidr_block              = "192.168.128.0/19"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "PrivateSubnet-2"
  }
}
resource "aws_subnet" "private_subnet_3" {
  vpc_id                  = aws_vpc.ank_vpc.id
  cidr_block              = "192.168.160.0/19"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = false
  tags = {
    Name = "PrivateSubnet-3"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "ank_igw" {
  vpc_id = aws_vpc.ank_vpc.id
  tags = {
    Name = "Internet-Gateway"
  }
}

# NatGW
resource "aws_nat_gateway" "natgw-1" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.public_subnet_1.id
  tags = {
    Name = "NAT-GW-1"
  }
  depends_on = [aws_internet_gateway.ank_igw]
}
resource "aws_eip" "nat-eip" {
  tags = {
    Name = "nat-eip"
  }
}
