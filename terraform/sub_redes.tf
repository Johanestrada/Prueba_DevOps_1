resource "aws_subnet" "publica" {
  vpc_id = aws_vpc.vpc-prueba1.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "privada" {
  vpc_id = aws_vpc.vpc-prueba1.id
  cidr_block = "10.0.2.0/24"
}