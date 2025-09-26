provider "aws" {
  region = "ap-south-2"
}

# VPC
resource "aws_vpc" "myvpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "test-project"
  }
}

# Subnet 1 (public)
resource "aws_subnet" "subnet-1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet-1"
  }
}

# Subnet 2 (public)
resource "aws_subnet" "subnet-2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet-2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "MY-IGW"
  }
}

# Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "route-table-custom"
  }
}

# Default route to IGW
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myigw.id
}

# Route Table Associations
resource "aws_route_table_association" "public_subnet_association1" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.subnet-1.id
}

resource "aws_route_table_association" "public_subnet_association2" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.subnet-2.id
}

