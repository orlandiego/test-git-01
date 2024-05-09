provider "aws"{
  region = "us-east-1"
}

resource "aws_instance" "web_instance_01" {
  ami                    = "ami-0a1179631ec8933d7"
  instance_type          = "t3.micro"
  key_name               = "vockey"
  tags = {
    Name      = "web_instance_01"
  }
}

resource "aws_security_group" "test_terraform_sg" {
  name        = "test-terraform-sg"
  description = "Grupo de seguridad para test Terraform"

  #Regla de ingreso para permitir el tráfico SSH en el puerto 22
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # Regla de salida para permitir cualquier tráfico saliente
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "test-terraform-sg"
  }
}

# Crear un VPC
resource "aws_vpc" "test_terraform_vpc" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "test-terraform-vpc"
  }
}

# Crear una subnet asociada al VPC
resource "aws_subnet" "test_terraform_subnet" {
  vpc_id                  = aws_vpc.test_terraform_vpc.id
  cidr_block              = "172.16.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "test-terraform-subnet"
  }
}

# Crear un Internet Gateway
resource "aws_internet_gateway" "test_terraform_ig" {
  vpc_id = aws_vpc.test_terraform_vpc.id
  tags = {
    Name = "test-terraform-ig"
  }
}

# Crear una Route Table
resource "aws_route_table" "test_terraform_rt" {
  vpc_id = aws_vpc.test_terraform_vpc.id

  tags = {
    Name = "test-terraform-rt"
  }
}

# Crear una Route Table Association
resource "aws_route_table_association" "test_terraform_rt_association" {
  subnet_id      = aws_subnet.test_terraform_subnet.id
  route_table_id = aws_route_table.test_terraform_rt.id
}

# Crear la ruta 0.0.0.0/0 via igw en la main route table
resource "aws_route" "test_terraform_main_route" {
  route_table_id         = aws_vpc.test_terraform_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.test_terraform_ig.id
}
