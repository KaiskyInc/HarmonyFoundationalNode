# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name    = "Harmony VPC"
    Project = "Harmony"
  }
}

# Internet gateway for public access
resource "aws_internet_gateway" "gateway" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name    = "Harmony VPC Internet Gateway"
    Project = "Harmony"
  }
}

# Grant the VPC internet access on its main route table
resource "aws_route" "route" {
  route_table_id         = "${aws_vpc.vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gateway.id}"
}

# Subnets 
resource "aws_subnet" "foundational-subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.subnet_cidr_block}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.subnet_az}"

  tags {
    Name    = "HarmonyFoundationalNode-Subnet"
    Project = "Harmony"
  }
}

# Security Group with Harmoney Foundational Node ports enabled
resource "aws_security_group" "foundational-sg" {
  name        = "Harmony Foundational Node Security Group"
  description = "Security group for Harmony Foundational Nodes"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Enable SSH"
  }

  ingress {
    from_port   = 6000
    to_port     = 6000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Harmony Foundational Port"
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Harmony Foundational Port"
  }

  ingress {
    from_port   = 14555
    to_port     = 14555
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Harmony Foundational Port"
  }

  ingress {
    from_port   = 9999
    to_port     = 9999
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Harmony Foundational Port"
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name    = "Harmony Foundational Node Security Group"
    Project = "Harmony"
  }
}
