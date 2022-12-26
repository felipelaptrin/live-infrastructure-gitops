terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-vpc.git//.?ref=v3.16.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name = "main-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  public_subnets  = ["10.0.112.0/20", "10.0.128.0/20", "10.0.144.0/20"]

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/eks-dev"   = "owned"
  }
  public_subnet_tags = {
    "kubernetes.io/role/elb"        = "1"
    "kubernetes.io/cluster/eks-dev" = "owned"
  }
}