terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-iam.git//modules/iam-eks-role?ref=v5.5.0"
}

include {
  path = find_in_parent_folders()
}

dependency "policy" {
  config_path = "../../iam-policy/cluster-autoscaler"
  mock_outputs = {
    arn = "arn:aws:iam::111111111111:policy/fake-policy"
  }
}

inputs = {
  role_name        = "cluster-autoscaler"
  role_description = "Allows Cluster Autoscaler to scale EKS cluster"
  cluster_service_accounts = {
    "eks-dev" = ["kube-system:cluster-autoscaler"]
  }
  role_policy_arns = {
    "cluster-autoscaler" = dependency.policy.outputs.arn
  }
}