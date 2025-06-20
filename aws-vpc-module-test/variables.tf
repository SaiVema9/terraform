variable "projectName" {
  default = "bestbuyonline"
}

variable "environmentName" {
  default = "dev"
}

variable "publicSubnetCidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "privateSubnetCidrs" {
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "databaseSubnetCidrs" {
  default = ["10.0.21.0/24", "10.0.22.0/24"]
}