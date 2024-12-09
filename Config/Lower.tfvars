#aws kms delete-alias --alias-name alias/eks/ecom
##########################################
############### General ##################
##########################################
project_name = "${project_name}"
env          = "dev"
region       = "${aws_region}"
tags = {
  Project         = "${project_name}"
  Environment     = "Dev"
  ManagedBy       = "${managed_by}"
  Confidentiality = "C2"
  TaggingVersion  = "V2.4"
  SecurityZone    = "A"
}