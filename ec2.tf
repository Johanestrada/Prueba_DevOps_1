# AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


# FRONTEND
resource "aws_instance" "frontend" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.publica.id

  key_name = "devops-key"

  vpc_security_group_ids = [aws_security_group.frontend_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd docker git
    systemctl start httpd
    systemctl enable httpd
    systemctl start docker
    systemctl enable docker

    cat <<HTML > /var/www/html/index.html
    <html>
        <body style="text-align:center;">
            <h1>Infraestructura DevOps funcionando :)</h1>
            <img src="https://static.wikia.nocookie.net/esfuturama/images/1/19/Fansworth.png/revision/latest/scale-to-width-down/230?cb=20130125191001" />
        </body>
    </html>
    HTML

EOF

  tags = {
    Name = "Frontend-EC2"
  }
}

# BACKEND
resource "aws_instance" "backend" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.privada.id

  key_name = "devops-key"

  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              # Java
              yum install -y java-17-amazon-corretto
              # Maven
              yum install -y maven
              # Docker + Git
              yum install -y docker git
              systemctl start docker
              systemctl enable docker
              echo "Backend listo para Spring Boot" > /home/ec2-user/backend.txt
              EOF

  tags = {
    Name = "Backend-EC2"
  }
}

# DATA (MYSQL)
resource "aws_instance" "servidor_datos" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  key_name      = "devops-key"

  subnet_id = aws_subnet.privada.id

  associate_public_ip_address = false

  vpc_security_group_ids = [aws_security_group.mysql.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y

              # Instalar MySQL correctamente en Amazon Linux 2
              amazon-linux-extras enable mysql8.0
              yum install -y mysql-community-server docker git

              systemctl start mysqld
              systemctl enable mysqld

              systemctl start docker
              systemctl enable docker
              EOF

  tags = {
    Name = "servidor-datos-mysql"
  }
}
