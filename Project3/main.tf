provider aws {
    region = var.region
}

# Creating VPC

resource "aws_vpc" "project3" {
  cidr_block           = var.vpc_dns[0].vpc_cidr
  enable_dns_support   = var.vpc_dns[0].dns_sup
  enable_dns_hostnames = var.vpc_dns[0].dns_host

  tags = {
    Name = var.vpc_dns[0].vpc_name
  }
}

# Creating  subnets

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.project3.id
  cidr_block = var.public_cidr[0].cidr
  map_public_ip_on_launch = true     
  availability_zone = "${var.region}a"

  tags = {
    Name = var.public_cidr[0].subnet_name
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.project3.id
  cidr_block = var.public_cidr[1].cidr
  map_public_ip_on_launch = true
  availability_zone = "${var.region}b"

  tags = {
    Name = var.public_cidr[1].subnet_name
  }
}

resource "aws_subnet" "public3" {
  vpc_id     = aws_vpc.project3.id
  cidr_block = var.public_cidr[2].cidr
  map_public_ip_on_launch = true
  availability_zone = "${var.region}b"

  tags = {
    Name = var.public_cidr[2].subnet_name
  }
}



# Creating Internet Gateway

resource "aws_internet_gateway" "project3" {
  vpc_id = aws_vpc.project3.id

  tags = {
    Name = var.ig
  }
}

# Creating route tables public and private

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.project3.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project3.id
  }
    tags = {
    Name = var.rt1
  }
}


# Association with subnets

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.public3.id
  route_table_id = aws_route_table.public.id
}
