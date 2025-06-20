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
