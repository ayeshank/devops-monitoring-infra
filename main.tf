provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "ank_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "ANKVPC"
  }
}

resource "aws_internet_gateway" "ank_igw" {
  vpc_id = aws_vpc.ank_vpc.id
  tags = {
    Name = "MyIGW"
  }
}
