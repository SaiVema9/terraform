#you can define any name instead of default
resource "aws_vpc_peering_connection" "default" {
  count = var.isPeeringRequired ? 1 : 0
  #Peer_owner_id is not required here as we are connecting to the same account   
  #peer_owner_id = var.peer_owner_id
  peer_vpc_id = data.aws_vpc.default.id #Acceptor
  vpc_id      = aws_vpc.main.id         #Requestor

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  auto_accept = true

  tags = merge(
    var.vpc_peering_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-public-default"
    }
  )
}

#creating route for public
resource "aws_route" "public_peering" {
  count = var.isPeeringRequired ? 1 : 0
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
}
#creating route for private
resource "aws_route" "private_peering" {
  count = var.isPeeringRequired ? 1 : 0
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
}
#creating route for database
resource "aws_route" "database_peering" {
  count = var.isPeeringRequired ? 1 : 0
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
}

#we should add peering connection in default VPC main route table too
resource "aws_route" "default_peering" {
  count = var.isPeeringRequired ? 1 : 0
  route_table_id            = data.aws_route_table.main.id
  destination_cidr_block    = var.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
}


