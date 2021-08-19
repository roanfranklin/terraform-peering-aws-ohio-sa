provider "aws" {
  region = var.region_ohio
}

provider "aws" {
  alias = "sa"
  region = var.region_sa
}

module "ohio" {
  source = "../ohio/"

  region_ohio = var.region_ohio
  cidr_ohio = var.cidr_ohio
  subnet_ohio_az1 = var.subnet_ohio_az1
  subnet_ohio_az2 = var.subnet_ohio_az2
}

module "sa" {
  source = "../sa/"

  region_sa = var.region_sa
  cidr_sa = var.cidr_sa
  subnet_sa_az1 = var.subnet_sa_az1
  subnet_sa_az2 = var.subnet_sa_az2
}