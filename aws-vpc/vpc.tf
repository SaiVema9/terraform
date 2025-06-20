#bestbuyonline-dev
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

  tags = merge(
    var.vpc_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}"
    }

  )
}
#bestbuyonline-dev-IG
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.igw_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-IG"
    }
  )
}
#bestbuyonline-dev-public-us-east-1a
#bestbuyonline-dev-public-us-east-1b
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.public_subnet_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-public-${local.az_names[count.index]}"
    }
  )
}
#bestbuyonline-dev-private-us-east-1a
#bestbuyonline-dev-private-us-east-1b
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]


  tags = merge(
    var.private_subnet_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-private-${local.az_names[count.index]}"
    }
  )
}
#bestbuyonline-dev-database-us-east-1a
#bestbuyonline-dev-database-us-east-1b
resource "aws_subnet" "database" {
  count             = length(var.database_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.database_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]


  tags = merge(
    var.database_subnet_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-database-${local.az_names[count.index]}"
    }
  )
}

#create elastic IP
resource "aws_eip" "eip_nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.nat_gateway_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-NAT"
    }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}
#creating route table for public
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.public_routetable_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-Public-Route"
    }
  )
}
#creating route table for private
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.private_routetable_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-Private-Route"
    }
  )
}
#creating route table for database
resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.database_routetable_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-database-Route"
    }
  )
}
#creating route for public
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}
#creating route for private
resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.main.id
}
#creating route for database
resource "aws_route" "database" {
  route_table_id         = aws_route_table.database.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.main.id
}

#public route table associated with both public subnets
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
#private route table associated with both private subnets
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
#database route table associated with both database subnets
resource "aws_route_table_association" "database" {
  count          = length(var.database_subnet_cidrs)
  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database.id
}

