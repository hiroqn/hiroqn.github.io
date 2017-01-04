provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_route53_zone" "inkaku_ink" {
  name = "inkaku.ink"
}

resource "aws_s3_bucket" "inkaku_ink" {
  bucket        = "inkaku.ink"
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
      "Resource": "arn:aws:s3:::inkaku.ink/*"
    }
  ]
}
EOF
}

resource "aws_route53_record" "inkaku_ink_root" {
  zone_id = "${aws_route53_zone.inkaku_ink.zone_id}"
  name    = "inkaku.ink"
  type    = "A"

  alias {
    name                   = "${aws_s3_bucket.inkaku_ink.website_domain}"
    zone_id                = "${aws_s3_bucket.inkaku_ink.hosted_zone_id}"
    evaluate_target_health = false
  }
}
