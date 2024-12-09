############################################
################## EKS #####################
############################################
module "cluster_eks" {
  source                               = "github.com/VFGroup-VBIT/vbitdc-terraform-module-infra.git//EKS?ref=v1.8.2"
  cluster_name                         = var.cluster_name
  cluster_version                      = var.cluster_version
  project_name                         = var.project_name
  env                                  = var.env
  cluster_vpc                          = module.network.vpc_id
  private_subnet_1a                    = module.network.private_subnets[0]
  private_subnet_1b                    = module.network.private_subnets[1]
  private_subnet_1c                    = module.network.private_subnets[2]
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  eks_managed_node_groups              = var.eks_managed_node_groups
  access_entries                       = var.access_entries
  tags                                 = var.tags
  kms_key_administrators               = var.kms_key_administrators
  sns-emails                           = ["dl-digitalchannels.sre@vodafone.com"]
  cluster_addons = {
    vpc-cni                = { most_recent = true }
    coredns                = { most_recent = true }
    kube-proxy             = { most_recent = true }
    aws-ebs-csi-driver     = { most_recent = true }
    eks-pod-identity-agent = { most_recent = true }
    aws-efs-csi-driver = {
      most_recent              = true
      service_account_role_arn = module.efs_addon_iam_assumable_role_with_oidc.iam_role_arn
    }
    amazon-cloudwatch-observability = {
      most_recent              = true
      service_account_role_arn = module.observability_addon_iam_assumable_role_with_oidc.iam_role_arn
    }
  }
}

data "aws_eks_cluster" "default" {
  name = var.cluster_name
  depends_on = [
    module.cluster_eks
  ]
}
data "aws_eks_cluster_auth" "default" {
  name = var.cluster_name
  depends_on = [
    module.cluster_eks
  ]
}