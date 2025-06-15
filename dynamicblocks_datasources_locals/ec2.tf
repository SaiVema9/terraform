
resource "aws_instance" "Terraform_EC2" {
  for_each               = var.instances
  ami                    = data.aws_ami.JoinDevOpsData.id
  instance_type          = each.value
  vpc_security_group_ids = [aws_security_group.Allow_All.id]

  tags = {
    Name = each.key
  }
}

resource "aws_security_group" "Allow_All" {
  name        = var.sg_name
  description = var.sg_description

  dynamic "ingress" {
    for_each = var.ingress_prots
    content {
      from_port        = ingress.value["from_port"]
      to_port          = ingress.value["to_port"]
      protocol         = var.protocol
      cidr_blocks      = var.cidr_blocks
      ipv6_cidr_blocks = var.ipv6_cidr_blocks
    }

  }

  dynamic "egress" {
    for_each = var.egress_prots
    content {
      from_port        = egress.value["from_port"]
      to_port          = egress.value["to_port"]
      protocol         = var.protocol
      cidr_blocks      = var.cidr_blocks
      ipv6_cidr_blocks = var.ipv6_cidr_blocks
    }

  }

  tags = var.SG_Tags
}
