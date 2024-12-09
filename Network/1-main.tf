##########################################
############### Network ##################
##########################################
module "network" {
  source                  = "github.com/VFGroup-VBIT/vbitdc-terraform-module-infra.git//Network?ref=v1.8.1"
  cidr_vpc                = var.cidr_vpc
  env                     = var.env
  tag_subnets_k8s_private = var.tag_subnets_k8s_private
  tag_subnets_k8s_public  = var.tag_subnets_k8s_public
  project_name            = var.project_name
  tags                    = var.tags
}
