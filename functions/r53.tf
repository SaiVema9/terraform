resource "aws_route53_record" "r53_records" {
  count   = length(var.instances)
  zone_id = var.r53ZoneId
  name    = "${var.instances[count.index]}.${var.domain_Name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.Terraform_EC2[count.index].private_ip]
}
