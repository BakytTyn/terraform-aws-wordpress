# Deploy EC2 with latest Amazone AMI image

data "aws_ami" "amzn2" {
  most_recent = true   

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*"]
    
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["137112412989"] 
}

resource "aws_instance" "linux" {
  ami           = data.aws_ami.amzn2.id
  instance_type = var.instance[0].ec2_type
  subnet_id = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id] 
  user_data = file("httpd.sh")
  
  tags = {
    Name = var.instance[0].ec2_name
  }
}

# RDS Instance
resource "aws_db_instance" "wordpress_db" {
  allocated_storage      = var.database_details.allocated_storage
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = var.database_details.instance_class
  identifier             = "wordpressdb"
  username               = var.database_details.username
  password               = var.database_details.password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.group_3.id]
  skip_final_snapshot    = true
}

# Database Subnet Group
resource "aws_db_subnet_group" "db_subnet" {
  name       = "my-db-subnet-group"
  subnet_ids = values(aws_subnet.public1).*.id
}

# Subdomain

resource "aws_route53_record" "subdomain" {
  zone_id = "Z06738651TK0FJ6ZYYGU5" // Replace with your hosted zone ID
  name    = "a-syl.com"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.group_3.public_ip] // Replace with the IP address of your web server
}