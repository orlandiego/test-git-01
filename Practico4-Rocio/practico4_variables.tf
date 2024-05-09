variable "aws_region" {
  type = string
  region = var.region
  description = "Variable para la region"
  default = 
}

variable "aws_vpc" {
  type = string
  vpc = var.vpc
  description = "Vaariable para el vpc"
  default = 
}

variable "vpc_cidr" {
  type = string
  CIDR = var.cidr
  description = "Variable para el CIDR block"
  default = 
}

variable "aws_subnet" {
  type = string
  subnet = var.subnet
  description = "Variable para la subred"
  default = 
}

variable "aws_internet_gateway" {
  type = string
  
  description = "Variable para el Gateway"
  default = 
}

variable "aws_default_route_table" {
  type = string
  description = "Variable para la ruta por defecto"
  default = 
}

variable "aws_route_table" {
  type = string
  description = "Variable para la tabla de ruteo"
  default = 
}

variable "aws_route_table_association" {
  type = string
  description = "Variable para ?"
  default = 
}

