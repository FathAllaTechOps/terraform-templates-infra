##########################################################
################## EKS Configuration #####################
##########################################################
module "eks_config" {
  source                  = "github.com/VFGroup-VBIT/vbitdc-terraform-module-infra.git///EKS_Config?ref=v1.8.2"
  project_name            = var.project_name
  env                     = var.env
  tags                    = var.tags
  oidc_provider_arn       = module.cluster_eks.oidc_provider_arn
  cluster_name            = module.cluster_eks.cluster_name
  eks_managed_node_groups = module.cluster_eks.eks_managed_node_groups
  labels_config           = var.labels_config
  namespaces_config       = var.namespaces_config
  alb_config              = var.alb_config
  nginx_config            = var.nginx_config
  autoscaler_config       = var.autoscaler_config
  external_dns_config     = var.external_dns_config
  kyverno_config          = var.kyverno_config
  ebs_sci_config          = var.ebs_sci_config
  network-module          = module.network
  eks-cluster             = module.cluster_eks
}