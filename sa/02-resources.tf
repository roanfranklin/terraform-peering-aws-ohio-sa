  # VPC
  resource "aws_vpc" "sa" {
    cidr_block = var.cidr_sa

    tags = tomap({
      name = "VPC South America"
    })
  }

  # Internet Gateway
  resource "aws_internet_gateway" "sa" {
    vpc_id = aws_vpc.sa.id
  }

  # Route
  resource "aws_route" "sa-internet_access" {
    route_table_id         = aws_vpc.sa.main_route_table_id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.sa.id
  }

  # Subnet 1
  resource "aws_subnet" "sa-az1" {
    vpc_id                  = aws_vpc.sa.id
    cidr_block              = var.subnet_sa_az1
    map_public_ip_on_launch = false
    availability_zone       = "${var.region_sa}a"
  }

  # Subnet 2
  resource "aws_subnet" "sa-az2" {
    vpc_id                  = aws_vpc.sa.id
    cidr_block              = var.subnet_sa_az2
    map_public_ip_on_launch = false
    availability_zone       = "${var.region_sa}b"
  }

  # Security Group
  resource "aws_security_group" "sa-default" {
    name_prefix = "SA Security Group"
    description = "Default security group for all instances in VPC ${aws_vpc.sa.id}"
    vpc_id      = aws_vpc.sa.id

    ingress {
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
      cidr_blocks = [
        aws_vpc.sa.cidr_block,
        #      aws_vpc.ohio.cidr_block
      ]
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
