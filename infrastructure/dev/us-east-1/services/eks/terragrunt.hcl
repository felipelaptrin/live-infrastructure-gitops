terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-eks.git?ref=v18.30.0"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    public_subnets = ["subnet-007e9a594e0730e02"]
    vpc_id         = "vpc-087d091e9535e8d75"
  }
}

inputs = {
  cluster_name                    = "eks-dev"
  cluster_version                 = "1.24"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  cluster_addons = {
    aws-ebs-csi-driver = {
      addon_version = "v1.13.0-eksbuild.2"
    }
    coredns = {
      resolve_conflicts = "OVERWRITE"
      addon_version     = "v1.8.7-eksbuild.3"
    }
    kube-proxy = {
      addon_version = "v1.24.7-eksbuild.2"
    }
    vpc-cni = {
      addon_version     = "v1.12.0-eksbuild.1"
      resolve_conflicts = "OVERWRITE"
    }
  }

  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.public_subnets

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::937168356724:user/flat-admin"
      username = "flat-admin"
      groups   = ["system:masters"]
    },
  ]

  eks_managed_node_groups = {
    spot = {
      min_size     = 1
      max_size     = 1
      desired_size = 1

      instance_types = ["m6a.large", "m5.large"]
      capacity_type  = "SPOT"
    }
  }

  node_security_group_additional_rules = {
    ingress_allow_access_from_control_plane = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 9443
      to_port                       = 9443
      source_cluster_security_group = true
      description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
    }
  }
}
