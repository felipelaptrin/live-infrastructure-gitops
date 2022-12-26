terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-s3-bucket.git//.?ref=v3.5.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  bucket = "flat-test-terragrunt-move"
  acl    = "private"
}