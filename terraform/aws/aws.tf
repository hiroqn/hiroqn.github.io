provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 10
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
}

/*
 _    __     _        _
| |_ / _|___| |_ __ _| |_ ___
| __| |_/ __| __/ _` | __/ _ \
| |_|  _\__ \ || (_| | ||  __/
 \__|_| |___/\__\__,_|\__\___|
*/
resource "aws_s3_bucket" "hiroqn_tfstate" {
  bucket        = "hiroqn-tfstate"
  acl           = "private"
  force_destroy = true
}

terraform {
  backend "s3" {
    bucket = "hiroqn-tfstate"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}
