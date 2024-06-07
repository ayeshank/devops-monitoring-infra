data "aws_availability_zones" "available" {
  state = "available" # Fetches only zones that are currently available for use
}

resource "aws_subnet" "public_subnet" {
  count                   = 3
  vpc_id                  = aws_vpc.ank_vpc.id
  cidr_block              = "10.0.${1 + count.index}.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "PublicSubnet-${count.index}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = 3
  vpc_id            = aws_vpc.ank_vpc.id
  cidr_block        = "10.0.${4 + count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "PrivateSubnet-${count.index}"
  }
}

resource "aws_eip" "nat_eip" {
  count = 1
  tags = {
    Name = "ANKNATEIP"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = 1
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public_subnet[0].id
  depends_on    = [aws_internet_gateway.ank_igw]
  tags = {
    Name = "ANKNATGateway"
  }
}
