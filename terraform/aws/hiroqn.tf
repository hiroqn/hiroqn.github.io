resource "aws_iam_user" "hiroqn" {
  name = "hiroqn"
}

resource "aws_iam_access_key" "hiroqn_aws_key" {
  user    = "${aws_iam_user.hiroqn.name}"
  pgp_key = "keybase:hiroqn"
}

resource "aws_iam_user_login_profile" "hiroqn_profile" {
  user    = "${aws_iam_user.hiroqn.name}"
  pgp_key = "keybase:hiroqn"
}

output "password" {
  value = "${aws_iam_user_login_profile.hiroqn_profile.encrypted_password}"
}

output "access_key" {
  value = "${aws_iam_access_key.hiroqn_aws_key.id}"
}

output "access_secret" {
  value = "${aws_iam_access_key.hiroqn_aws_key.encrypted_secret}"
}

resource "aws_iam_user_policy" "hiroqn_policy" {
  name = "hiroqn-admin-policy"

  policy = <<EOF
{
  "Version"  : "2012-10-17",
  "Statement": [
    {
      "Effect"  : "Allow",
      "Action"  : "*",
      "Resource": "*"
    }
  ]
}
EOF

  user = "hiroqn"
}
