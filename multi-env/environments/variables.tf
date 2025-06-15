variable "ami_id" {
  type        = string
  default     = "ami-09c813fb71547fc4f"
  description = "RedHat_Devops_AMI"
}
variable "instance_type" {

}

variable "ec2_tags" {
  type = map(string)
  default = {
    Name = "SampleEC2CreatedFromTerraform"
  }
}
variable "sg_name" {
  default = "Allow_All"
}
variable "sg_description" {
  default = "Allowing all ports from internet"
}
variable "from_port" {
  default = 0
}
variable "to_port" {
  default = 0
}
variable "cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
variable "protocol" {
  default = "-1"
}
variable "ipv6_cidr_blocks" {
  type    = list(string)
  default = ["::/0"]
}
/* variable "SG_Tags" {
  type = map(string)
  default = {
    Name = "Terraform_SG"
  }
} */

variable "SG_Tags" {
  default = "Terraform_SG"
}

variable "instances" {
  default = ["frontend", "backend", "database"]
}

variable "domain_name" {
  default = "bestbuyonline.store"
}

variable "common_tags" {
  default = {
    project = "roboshop"
    terraform = true
  }
}

variable "environment" {
  
}

variable "project" {
  default = "roboshop"
}

