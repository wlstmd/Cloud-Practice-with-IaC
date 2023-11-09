resource "aws_eip" "wsi-nat-eip" {
  domain = "vpc"
  tags = {
    Name = "wsi-nat-eip"
  }
}

resource "aws_eip" "wsi-nat-eip2" {
  domain = "vpc"
  tags = {
    Name = "wsi-nat-eip2"
  }
}
