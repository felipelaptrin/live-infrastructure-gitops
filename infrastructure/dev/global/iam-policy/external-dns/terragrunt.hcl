terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy?ref=v5.5.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name        = "external-dns"
  description = "Policy for Kubernetes External DNS"
  policy      = file("policy.json")
}