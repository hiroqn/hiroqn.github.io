resource "aws_route53_zone" "hiroqn_me" {
  name = "hiroqn.me"
}

resource "aws_route53_record" "hiroqn_me" {
  zone_id = "${aws_route53_zone.hiroqn_me.zone_id}"
  name    = "hiroqn.me"
  type    = "A"
  records = ["66.6.44.4"]
  ttl     = "3600"
}

resource "aws_route53_zone" "hiroqn_net" {
  name = "hiroqn.net"
}
