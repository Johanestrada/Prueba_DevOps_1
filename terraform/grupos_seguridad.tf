resource "aws_security_group" "mysql" {
	name   = "mysql-sg"
	vpc_id = aws_vpc.vpc-prueba1.id

	ingress {
		from_port   = 3306
		to_port     = 3306
		protocol    = "tcp"
		security_groups = [aws_security_group.grupo_seguridad_backend.id] # Solo backend accede
	}

	ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"] # SSH desde cualquier lugar (ajusta según necesidad)
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name = "mysql-sg"
	}
}
