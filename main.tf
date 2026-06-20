resource "aws_security_group" "nginx_sg" {
  name = "nginx-security-group-v2"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "nginx_server" {

  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = "t2.micro"

  security_groups = [
    aws_security_group.nginx_sg.name
  ]

  user_data = file("${path.module}/user-data.sh")

  tags = {
    Name = "terraform-nginx-server"
  }
}


output "public_ip" {
  value = aws_instance.nginx_server.public_ip
}