Innovatech Chile – Migración a AWS con Terraform
Este repositorio contiene la infraestructura como código para desplegar una arquitectura segura y escalable en Amazon Web Services (AWS) utilizando Terraform. El proyecto corresponde a la defensa académica de la asignatura de Ingeniería Informática y busca implementar una solución modular y reproducible.

Arquitectura
VPC (10.0.0.0/16) con subred pública y privadas.

Front-End (EC2 con Docker y Nginx) en subred pública, accesible vía HTTP/HTTPS.

Back-End (EC2 con Docker API) en subred privada, accesible solo desde el Front-End.

Base de Datos (MySQL) en subred privada dedicada, accesible solo desde el Back-End.

Internet Gateway para exposición del Front-End.

NAT Gateway en la subred pública para salida segura de las privadas.

Security Groups aplicando el principio de mínimo privilegio:

SG-Front: HTTP/HTTPS y SSH restringido.

SG-Back: Solo tráfico desde Front en puerto 3000.

