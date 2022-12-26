terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-iam.git//modules/iam-eks-role?ref=v5.5.0"
}

include {
  path = find_in_parent_folders()
}

dependency "policy" {
  config_path = "../../iam-policy/external-dns"
  mock_outputs = {
    arn = "arn:aws:iam::111111111111:policy/fake-policy"
  }
}

inputs = {
  role_name        = "external-dns"
  role_description = "Allows External DNS to use Route 53"
  cluster_service_accounts = {
    "eks-dev" = ["kube-system:external-dns"]
  }
  role_policy_arns = {
    "external-dns" = dependency.policy.outputs.arn
  }
}