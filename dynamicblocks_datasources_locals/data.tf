data "aws_ami" "JoinDevOpsData" {
  owners      = ["973714476881"]
  most_recent = true

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "Aws_ami_data" {
  value = data.aws_ami.JoinDevOpsData.id
}
