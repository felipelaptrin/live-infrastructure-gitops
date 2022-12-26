terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy?ref=v5.5.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name        = "aws-load-balancer-controller-policy"
  description = "Policy for AWS Load Balancer Controller be able to manage load balancers"
  policy      = file("policy.json")
}