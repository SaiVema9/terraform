variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list
}

variable "private_subnet_cidrs" {
  type = list
}

variable "database_subnet_cidrs" {
  type = list
}

#It's optional - hence default set to blank to make it optional for users
variable "vpc_tags" {
  type = map(string)
  default = {}
}
#It's optional - hence default set to blank to make it optional for users
variable "igw_tags" {
  type = map(string)
  default = {}
}
#It's optional - hence default set to blank to make it optional for users
variable "public_subnet_tags" {
  type = map(string)
  default = {}
}
#It's optional - hence default set to blank to make it optional for users
variable "private_subnet_tags" {
  type = map(string)
  default = {}
}
#It's optional - hence default set to blank to make it optional for users
variable "database_subnet_tags" {
  type = map(string)
  default = {}
}
#It's optional - hence default set to blank to make it optional for users
variable "nat_gateway_tags" {
  type = map(string)
  default = {}
}
#It's optional - hence default set to blank to make it optional for users
variable "public_routetable_tags" {
  type = map(string)
  default = {}
}
#It's optional - hence default set to blank to make it optional for users
variable "private_routetable_tags" {
  type = map(string)
  default = {}
}
#It's optional - hence default set to blank to make it optional for users
variable "database_routetable_tags" {
  type = map(string)
  default = {}
}

variable "isPeeringRequired" {
  default = false
}
#It's optional - hence default set to blank to make it optional for users
variable "vpc_peering_tags" {
  type = map(string)
  default = {}
}
