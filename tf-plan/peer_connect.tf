data "aws_caller_identity" "current" {}

# Peering Connection
resource "aws_vpc_peering_connection" "peerconnection" {
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_vpc_id   = module.sa.vpc_id
  vpc_id        = module.ohio.vpc_id

  peer_region   = var.region_sa

  auto_accept = false

  tags = {
    Name = "VPC Peering between Ohio and SA"
  }

  #   accepter {
  #     allow_remote_vpc_dns_resolution = true
  #   }

  #   requester {
  #     allow_remote_vpc_dns_resolution = true
  #   }
}

# Ohio Connection
resource "aws_route" "peerconnection-ohio2sa" {
  route_table_id            = module.ohio.route_table.main_route_table_id
  destination_cidr_block    = module.sa.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peerconnection.id
}

# South America Connection
resource "aws_route" "peerconnection-sa2ohio" {
  provider = aws.sa
  route_table_id            = module.sa.route_table.main_route_table_id
  destination_cidr_block    = module.ohio.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peerconnection.id
}
