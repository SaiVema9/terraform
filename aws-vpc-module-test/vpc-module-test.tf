module "vpc" {
  source = "../AWS-VPC"
  # project is mandatory to give because in module we have left with empty value hence we need to provide it here
  project = var.projectName
  # environment is mandatory to give because in module we have left with empty value hence we need to provide it here
  environment = var.environmentName
  #subnet_cidrs should be sent from here by users
  public_subnet_cidrs = var.publicSubnetCidrs
  private_subnet_cidrs = var.privateSubnetCidrs
  database_subnet_cidrs = var.databaseSubnetCidrs
  isPeeringRequired = true
}