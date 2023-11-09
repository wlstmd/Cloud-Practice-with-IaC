resource "aws_route_table" "wsi-rtb-public" {
  vpc_id = aws_vpc.wsi-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wsi-igw.id
  }

  tags = {
    Name = "wsi-rtb-public"
  }
}

resource "aws_route_table" "wsi-rtb-private-a" {
  vpc_id = aws_vpc.wsi-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.wsi-natgw-a.id
  }

  tags = {
    Name = "wsi-rtb-private-a"
  }
}

resource "aws_route_table" "wsi-rtb-private-b" {
  vpc_id = aws_vpc.wsi-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.wsi-natgw-b.id
  }

  tags = {
    Name = "wsi-rtb-private-b"
  }
}

resource "aws_route_table_association" "wsi-rtb-public-association-a" {
  subnet_id      = aws_subnet.wsi-subnet-public-a.id
  route_table_id = aws_route_table.wsi-rtb-public.id
}

resource "aws_route_table_association" "wsi-rtb-public-association-b" {
  subnet_id      = aws_subnet.wsi-subnet-public-b.id
  route_table_id = aws_route_table.wsi-rtb-public.id
}

resource "aws_route_table_association" "wsi-rtb-private-a-association" {
  subnet_id      = aws_subnet.wsi-subnet-private-a.id
  route_table_id = aws_route_table.wsi-rtb-private-a.id
}

resource "aws_route_table_association" "wsi-rtb-private-b-association" {
  subnet_id      = aws_subnet.wsi-subnet-private-b.id
  route_table_id = aws_route_table.wsi-rtb-private-b.id
}

