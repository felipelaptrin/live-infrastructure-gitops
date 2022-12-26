terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-iam.git//modules/iam-group-with-policies?ref=v5.5.0"
}

include {
  path = find_in_parent_folders()
}

dependency "user" {
  config_path = "../../iam-user"
  mock_outputs = {
    iam_user_name = "fake-user"
  }
}

inputs = {
  name = "adm"
  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ],
  group_users = [
    dependency.user.outputs.iam_user_name
  ]
}