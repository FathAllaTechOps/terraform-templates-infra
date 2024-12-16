##########################################
############# VPC Peering ################
##########################################
module "vpc_peering_requester" {
  source           = "github.com/VFGroup-VBIT/vbitdc-terraform-module-infra.git//VPC_Peering?ref=v1.7.6"
  REQUESTOR        = true
  REQUESTOR_VPC_ID = module.network.vpc_id
  REQUESTOR_CIDR   = var.cidr_vpc
  ACCEPTOR_ACCOUNT = "185664191886"          # MAAC-MGMT ACCOUNT ID
  ACCEPTOR_VPC_ID  = "vpc-021ba6d8f4cc97868" # Observability VPC ID
  ACCEPTOR_CIDR    = "10.20.0.0/16"          # Observability VPC CIDR
  REGION           = var.region
  CREATE_ROUTES    = true
  ROUTE_TABLES     = module.network.private_routing_tables_id
  TAGS             = var.tags
}
