resource "aws_vpc" "wsi-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "wsi-vpc"
  }
}