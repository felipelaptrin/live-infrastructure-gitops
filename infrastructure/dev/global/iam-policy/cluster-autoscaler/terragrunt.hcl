terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy?ref=v5.5.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name        = "cluster-autoscaler-policy"
  description = "Policy for Cluster Autoscaler be able to scale EKS cluster correctly"
  policy      = file("policy.json")
}