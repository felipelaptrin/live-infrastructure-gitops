# live-infrastructure-gitops


## Description
This is a simple project using Terragrunt (using a live-repo structure) and ArgoCD (applying GitOps principles) to deploy some test apps using AWS EKS.

## Architecture

The architecture is displayed above. Every component (such as EKS, IAM Role and VPC) was created using Terragrunt.

![Architecture](/docs/architecture.png "Architecture")
