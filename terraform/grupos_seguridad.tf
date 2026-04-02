// Grupo de seguridad para lo que es el front
resource "aws_security_group" "frontend_sg" {
    name = "Frontend-Prueba"
    vpc_id = aws_vpc.vpc-prueba1.id

    // Ahora vienen las que serian las reglas de entrada y de salida
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # Esto es para que cualquier Ip se pueda conectar 
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks =  ["0.0.0.0/0"] # Deberia permitir El HTTP desde cualquier Ip

    } 
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"] # como Ingress permite la entrada el egrese les permite la salida por cualquier destino
    }
}

## ahora vamos con lo que seria para el backend
resource "aws_security_group" "backend_sg" {
    vpc_id = aws_vpc.vpc-prueba1.id
    name = "Backend-SG"

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        # Este trafico  es desde el Front
        security_groups = [aws_security_group.frontend_sg.id]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

## Este grupo solo recibira desde el trafico desde el backend
