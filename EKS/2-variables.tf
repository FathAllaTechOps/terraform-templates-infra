##########################################
################# EKS ####################
##########################################
variable "cluster_name" {
  type = string
}
variable "cluster_version" {
  type = string
}
variable "cluster_endpoint_public_access_cidrs" {
  type = list(string)
}
variable "eks_managed_node_groups" {
  description = "Map of node group configurations"
  type        = map(any)
}

variable "kms_key_administrators" {
  description = "A list of IAM ARNs for [key administrators](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-default.html#key-policy-default-allow-administrators). If no value is provided, the current caller identity is used to ensure at least one key admin is available"
  type        = list(string)
  default     = []
}

variable "access_entries" {
  description = "Map of access entries to add to the cluster"
  type        = any
  default     = {}
}
