resource "aws_route53_record" "r53_records" {
  for_each = aws_instance.Terraform_EC2
  zone_id  = var.r53ZoneId
  name     = "${each.key}.${var.domain_Name}"
  type     = "A"
  ttl      = 300
  records  = [each.value.private_ip]
}
