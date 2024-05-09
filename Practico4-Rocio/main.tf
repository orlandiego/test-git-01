provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "web-instance-01" {
  ami                    = "ami-051f8a213df8bc089"
  instance_type          = "t3.micro"
  key_name               = "vockey"
  tags = {
    Name      = "practico1"
  }
}