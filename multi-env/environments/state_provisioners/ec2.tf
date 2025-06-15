
resource "aws_instance" "Terraform_EC2" {
  #count                  = length(var.instances)
  count                  = 1
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.Allow_All.id]

  tags = {
    Name = var.instances[count.index]
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> inventory.txt"
    on_failure = continue
  }
  provisioner "local-exec" {
    when = destroy
    command = "echo  Inventory file is empty now > inventory.txt"
    on_failure = continue
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [ 
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx"

     ]
  }
  provisioner "remote-exec" {
    when = destroy
    inline = [ 
      "sudo systemctl stop nginx"
     ]
  }

  
}



resource "aws_security_group" "Allow_All" {
  name        = var.sg_name
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



  tags = var.SG_Tags


}
