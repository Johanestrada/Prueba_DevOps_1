# ==============================
# TABLA DE RUTAS PÚBLICA
# ==============================
resource "aws_route_table" "tabla_publica" {
  vpc_id = aws_vpc.vpc-prueba1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "tabla-publica"
  }
}

# ==============================
# TABLA DE RUTAS PRIVADA
# ==============================
resource "aws_route_table" "tabla_privada" {
  vpc_id = aws_vpc.vpc-prueba1.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "tabla-privada"
  }

  depends_on = [aws_nat_gateway.nat]
}

# ==============================
# ASOCIACIÓN SUBRED PÚBLICA
# ==============================
resource "aws_route_table_association" "asociacion_publica" {
  subnet_id      = aws_subnet.publica.id
  route_table_id = aws_route_table.tabla_publica.id
}

# ==============================
# ASOCIACIÓN SUBRED PRIVADA
# ==============================
resource "aws_route_table_association" "asociacion_privada" {
  subnet_id      = aws_subnet.privada.id
  route_table_id = aws_route_table.tabla_privada.id
}