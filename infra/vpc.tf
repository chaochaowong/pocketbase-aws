resource "aws_vpc" "pocketbase" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "pocketbase" {
  vpc_id = aws_vpc.pocketbase.id

  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_subnet" "pocketbase" {
  vpc_id                  = aws_vpc.pocketbase.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_name
  }
}

resource "aws_route_table" "pocketbase_public" {
  vpc_id = aws_vpc.pocketbase.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pocketbase.id
  }

  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route_table_association" "pocketbase_public" {
  subnet_id      = aws_subnet.pocketbase.id
  route_table_id = aws_route_table.pocketbase_public.id
}
