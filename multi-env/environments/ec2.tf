
resource "aws_instance" "Terraform_EC2" {
  count                  = length(var.instances)
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.Allow_All.id]

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project}-${var.instances[count.index]}-${var.environment}-${var.domain_name}"
      Component = var.instances[count.index]
      Environment = var.environment
    }

  )
  
/*   provisioner "local-exec" {
    command = "echo ${self.public_ip} >> inventory.txt"
    on_failure = continue
  }
  provisioner "local-exec" {
    when = destroy
    command = "echo  Inventory file is empty now > inventory.txt"
    on_failure = continue
  } */

  
}



resource "aws_security_group" "Allow_All" {
  name        = "${var.project}-${var.environment}-${var.sg_name}"
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
      Name = "${var.project}-${var.SG_Tags}-${var.environment}"
    }
  )


}
