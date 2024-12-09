
##########################################################
################## EKS Configuration #####################
##########################################################
variable "labels_config" {
  type        = any
  description = "Configuration for Kubernetes labels to be applied to existing namespaces."
}
variable "namespaces_config" {
  type = map(object({
    labels      = optional(map(string))
    annotations = optional(map(string))
  }))
  description = "Configuration for Kubernetes namespaces including labels and annotations."
}
variable "alb_config" {
  type        = any
  description = "Configuration for deploying an Application Load Balancer (ALB)."
}
variable "nginx_config" {
  type        = any
  description = "Configuration for deploying Nginx Ingress Controller."
}
variable "external_dns_config" {
  type        = any
  description = "Configuration for deploying External DNS for Kubernetes."
}
variable "autoscaler_config" {
  type        = any
  description = "Configuration for deploying the Kubernetes Cluster Autoscaler."
}
variable "kyverno_config" {
  type        = any
  description = "Configuration for deploying Kyverno, a policy engine for Kubernetes."
}
variable "ebs_sci_config" {
  type        = any
  description = "Configuration for deploying EBS SCI Storage Class"
}
variable "external-secrets-operator-config" {
  description = "Configuration for deploying external secrets operator"
  type = object({
    enable                  = bool
    helmChartVersion        = string
    helm_values_file        = optional(list(string))
    secrets-access-role-arn = optional(string)
  })
}
