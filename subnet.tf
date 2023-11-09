resource "aws_subnet" "wsi-subnet-public-a" {
  vpc_id = aws_vpc.wsi-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "wsi-subnet-public-a"
  }
}

resource "aws_subnet" "wsi-subnet-public-b" {
  vpc_id = aws_vpc.wsi-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "wsi-subnet-public-b"
  }
}

resource "aws_subnet" "wsi-subnet-private-a" {
  vpc_id = aws_vpc.wsi-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "wsi-subnet-private-a"
  }
}

resource "aws_subnet" "wsi-subnet-private-b" {
  vpc_id = aws_vpc.wsi-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "wsi-subnet-private-b"
  }
}
