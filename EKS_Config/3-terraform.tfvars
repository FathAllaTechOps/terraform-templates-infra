##########################################################
################## EKS Configuration #####################
##########################################################
labels_config = {
  "default" = {
    "pod-security.kubernetes.io/enforce" = "baseline"
    "pod-security.kubernetes.io/warn"    = "restricted"
  },
  "kube-system" = {
    "pod-security.kubernetes.io/warn"  = "baseline"
    "pod-security.kubernetes.io/audit" = "restricted"
  },
  "kube-node-lease" = {
    "pod-security.kubernetes.io/enforce" = "baseline"
    "pod-security.kubernetes.io/warn"    = "restricted"
  },
  "kube-public" = {
    "pod-security.kubernetes.io/enforce" = "baseline"
    "pod-security.kubernetes.io/warn"    = "restricted"
  }
}
namespaces_config = {
  "dev" = {
    labels = {
      "pod-security.kubernetes.io/enforce" = "baseline"
      "pod-security.kubernetes.io/warn"    = "restricted"
    }
  },
  "sit" = {
    labels = {
      "pod-security.kubernetes.io/enforce" = "baseline"
      "pod-security.kubernetes.io/warn"    = "restricted"
    }
  }
}
alb_config = {
  enable           = true
  helmChartVersion = "1.10.1"
}
nginx_config = {
  enable           = true
  helmChartVersion = "4.11.3"
  helm_values_file = "./Helm_Values/nginx-ingress-helm-values-lower.yaml"
}
external_dns_config = {
  enable           = true
  helmChartVersion = "8.6.1"
  helm_values_file = "./Helm_Values/external-dns-helm-values.yaml"
}
autoscaler_config = {
  enable       = true
  imageVersion = "1.29.3"
}
kyverno_config = {
  enable           = true
  helmChartVersion = "3.3.3"
}
ebs_sci_config = {
  enable = true
}

external-secrets-operator-config = {
  enable                  = true
  helmChartVersion        = "0.9.20"
  helm_values_file        = []
  secrets-access-role-arn = ""
}
