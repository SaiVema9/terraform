locals {
  common_tags = {
    project = var.project
    environment = var.environment
    terraform = "true"
  }

  #slice (list,startindex,endindex) - Startindex is inclusive, endindex is exclusive
  az_names = slice(data.aws_availability_zones.available.names, 0, 2)
}