resource "aws_instance" "servidor_datos" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  key_name      = "spa-key"
  subnet_id     = aws_subnet.privada.id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.mysql.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install mysql-server -y
              systemctl start mysqld
              systemctl enable mysqld
              EOF

  tags = {
    Name = "servidor-datos-mysql"
  }
}