## ahora vamos con lo fuerte guaton las 3 instancias


resource "aws_instance" "frontend" {
    ami = "ami-0c55b159cbfafelf0"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.publica.id
    security_groups = [aws_security_group.frontend_sg.id]
    # esta lecera de abajo seria para inicialize  la instancia y arranque 
     user_data =  <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF

    tags = {
        Name = "Frontend-EC2"
    }
}

#Frontend
resource "aws_instance" "backend" {
    ami = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.privada.id
    security_groups = [aws_security_group.backend_sg.id]

    user_data =  <<-EOF
              #!/bin/bash
              yum update -y
              echo "Backend service running" > /home/ec2-user/backend.txt
              EOF
    tags = {
        Name = "Backend-EC2"
    }          
    
}