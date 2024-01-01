data "aws_route53_zone" "default" {
  name         = "hyo-gaku.com"
  private_zone = false
}

resource "aws_route53_record" "default" {
  zone_id = data.aws_route53_zone.default.zone_id
  name    = "hyo-gaku.com"
  type    = "A"
  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}