resource "aws_vpc" "vpc-prueba1" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-prueba1"
  }
}