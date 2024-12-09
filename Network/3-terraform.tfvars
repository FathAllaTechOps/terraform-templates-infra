##########################################
############### Network ##################
##########################################
cidr_vpc = "${vpc_cidr_range}"
tag_subnets_k8s_private = {
  Project                           = "${project_name}"
  Environment                       = "Dev"
  ManagedBy                         = "${managed_by}"
  Confidentiality                   = "C2"
  TaggingVersion                    = "V2.4"
  SecurityZone                      = "A"
  "kubernetes.io/role/internal-elb" = "1"
}
tag_subnets_k8s_public = {
  Project                  = "${project_name}"
  Environment              = "Dev"
  ManagedBy                = "${managed_by}"
  Confidentiality          = "C2"
  TaggingVersion           = "V2.4"
  SecurityZone             = "A"
  "kubernetes.io/role/elb" = "1"
}
