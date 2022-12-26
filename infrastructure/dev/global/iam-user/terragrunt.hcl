terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-iam.git//modules/iam-user?ref=v5.5.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name                          = "dev-1"
  create_iam_access_key         = false
  force_destroy                 = true
  create_iam_user_login_profile = false
}