resource "aws_route53_zone" "hiroqn_wiki" {
  name = "hiroqn.wiki"
}

resource "aws_route53_record" "hiroqn_wiki_root" {
  zone_id = "${aws_route53_zone.hiroqn_wiki.zone_id}"
  name    = "hiroqn.wiki"
  type    = "A"

  alias {
    name                   = "${aws_s3_bucket.hiroqn_wiki.website_domain}"
    zone_id                = "${aws_s3_bucket.hiroqn_wiki.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_s3_bucket" "hiroqn_wiki" {
  bucket        = "hiroqn.wiki"
  acl           = "public-read"
  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::hiroqn.wiki/*"
    }
  ]
}
EOF
}
