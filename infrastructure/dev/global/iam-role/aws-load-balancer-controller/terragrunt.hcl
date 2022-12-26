terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-iam.git//modules/iam-eks-role?ref=v5.5.0"
}

include {
  path = find_in_parent_folders()
}

dependency "policy" {
  config_path = "../../iam-policy/aws-load-balancer-controller"
  mock_outputs = {
    arn = "arn:aws:iam::111111111111:policy/fake-policy"
  }
}

inputs = {
  role_name        = "aws-load-balancer-controller"
  role_description = "Allows Cluster Autoscaler to scale EKS cluster"
  cluster_service_accounts = {
    "eks-dev" = ["kube-system:aws-load-balancer-controller"]
  }
  role_policy_arns = {
    "aws-load-balancer-controller" = dependency.policy.outputs.arn
  }
}