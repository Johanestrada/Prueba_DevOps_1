# =========================
# FRONTEND
# =========================
resource "aws_instance" "frontend" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.publica.id

  vpc_security_group_ids = [aws_security_group.frontend_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd docker
              systemctl start httpd
              systemctl enable httpd
              systemctl start docker
              systemctl enable docker
              EOF

  tags = {
    Name = "Frontend-EC2"
  }
}

# =========================
# BACKEND
# =========================
resource "aws_instance" "backend" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.privada.id

  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              systemctl start docker
              systemctl enable docker
              echo "Backend activo" > /home/ec2-user/backend.txt
              EOF

  tags = {
    Name = "Backend-EC2"
  }
}

# =========================
# DATA (TU PARTE)
# =========================
resource "aws_instance" "servidor_datos" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = "spa-key"

  subnet_id = aws_subnet.privada.id

  associate_public_ip_address = false

  vpc_security_group_ids = [aws_security_group.mysql.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y mysql-server docker
              systemctl start mysqld
              systemctl enable mysqld
              systemctl start docker
              systemctl enable docker
              EOF

  tags = {
    Name = "servidor-datos-mysql"
  }
}