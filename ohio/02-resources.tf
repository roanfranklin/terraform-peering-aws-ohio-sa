  # VPC
  resource "aws_vpc" "ohio" {
    cidr_block = var.cidr_ohio

    tags = tomap({
      name = "VPC Ohio"
    })
  }

  # Internet Gateway
  resource "aws_internet_gateway" "ohio" {
    vpc_id = aws_vpc.ohio.id
  }

  # Route
  resource "aws_route" "ohio-internet_access" {
    route_table_id         = aws_vpc.ohio.main_route_table_id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.ohio.id
  }

  # Subnet 1
  resource "aws_subnet" "ohio-az1" {
    vpc_id                  = aws_vpc.ohio.id
    cidr_block              = var.subnet_ohio_az1
    map_public_ip_on_launch = false
    availability_zone       = "${var.region_ohio}a"
  }

  # Subnet 2
  resource "aws_subnet" "ohio-az2" {
    #  provider = aws.ohio
    vpc_id                  = aws_vpc.ohio.id
    cidr_block              = var.subnet_ohio_az2
    map_public_ip_on_launch = false
    availability_zone       = "${var.region_ohio}b"
  }
  # Security Group
  resource "aws_security_group" "ohio-default" {
    name_prefix = "Ohio Security Group"
    description = "Default security group for all instances in VPC ${aws_vpc.ohio.id}"
    vpc_id      = aws_vpc.ohio.id

    ingress {
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
      cidr_blocks = [
        aws_vpc.ohio.cidr_block,
        #      aws_vpc.sa.cidr_block
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