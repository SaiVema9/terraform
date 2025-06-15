
resource "aws_instance" "Terraform_EC2" {
  count                  = 1
  ami                    = "ami-09c813fb71547fc4f"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.Allow_All.id]

  tags = {
    Name = "SampleEC2CreatedFromTerraform"
  }
}



resource "aws_security_group" "Allow_All" {
  name        = "Terraform_SG_allow_all"
  description = "Allow all traffic"

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }



  tags = {
    Name = "Terraform_SG"
  }


}
