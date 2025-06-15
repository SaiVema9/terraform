
resource "aws_instance" "Terraform_EC2" {
  count                  = length(var.instances)
  ami                    = var.ami_id
  instance_type          = lookup(var.instance_type, terraform.workspace)
  vpc_security_group_ids = [aws_security_group.Allow_All.id]

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.instances[count.index]}-${terraform.workspace}-${var.domain_name}"
      Component   = var.instances[count.index]
      Environment = terraform.workspace
    }
  )
  provisioner "local-exec" {
    command    = "echo Public IP Address of ${var.project}-${var.instances[count.index]}-${terraform.workspace}-${var.domain_name} = ${self.public_ip} >> PublicIP-${terraform.workspace}-Inventory.txt"
    on_failure = continue
  }
  provisioner "local-exec" {
    command    = "echo Private IP Address of ${var.project}-${var.instances[count.index]}-${terraform.workspace}-${var.domain_name} = ${self.private_ip} >> PrivateIP-${terraform.workspace}-Inventory.txt"
    on_failure = continue
  }
  provisioner "local-exec" {
    when       = destroy
    command    = "echo  : > PublicIP-${terraform.workspace}-Inventory.txt"
    on_failure = continue
  }
  provisioner "local-exec" {
    when       = destroy
    command    = "echo  : > PrivateIP-${terraform.workspace}-Inventory.txt"
    on_failure = continue
  }
}
resource "aws_security_group" "Allow_All" {
  name        = "${var.project}-${terraform.workspace}-${var.sg_name}"
  description = var.sg_description

  ingress {
    from_port        = var.from_port
    to_port          = var.to_port
    protocol         = var.protocol
    cidr_blocks      = var.cidr_blocks
    ipv6_cidr_blocks = var.ipv6_cidr_blocks
  }
  egress {
    from_port        = var.from_port
    to_port          = var.to_port
    protocol         = var.protocol
    cidr_blocks      = var.cidr_blocks
    ipv6_cidr_blocks = var.ipv6_cidr_blocks
  }
  tags = merge(
    var.common_tags,
    {
      Name = "${var.project}-${var.SG_Tags}-${terraform.workspace}"
    }
  )
}


