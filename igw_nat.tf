resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc-prueba1.id
}

resource "aws_eip" "nat" {}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.publica.id
}