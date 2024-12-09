##########################################
############### Netwrok ##################
##########################################
variable "cidr_vpc" {
  type        = string
  description = "vpc cidr block"
}
variable "tag_subnets_k8s_private" {
  type        = map(any)
  description = "tag to private subnets"
}
variable "tag_subnets_k8s_public" {
  type        = map(any)
  description = "tags to public subnetes"
}