resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id     = aws_vpc.project3.id

 ingress {  # inbound rules incoming traffic
    description      = "provide port 22"
    from_port        = var.ports[0]
    to_port          = var.ports[0]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {  # inbound rules incoming traffic
    description      = "provide port 80"
    from_port        = var.ports[1]
    to_port          = var.ports[1]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {  # inbound rules incoming traffic
    description      = "provide port 3306"
    from_port        = var.ports[2]
    to_port          = var.ports[2]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {  # inbound rules incoming traffic
    description      = "provide port 443"
    from_port        = var.ports[3]
    to_port          = var.ports[3]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}