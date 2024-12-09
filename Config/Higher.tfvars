#aws kms delete-alias --alias-name alias/eks/ecom
##########################################
############### General ##################
##########################################
project_name = "ecom"
env          = "prod"
region       = "eu-west-1"
tags = {
  Project         = "ecom"
  Environment     = "PROD"
  ManagedBy       = "basma.kamal2@vodafone.com"
  Confidentiality = "C2"
  TaggingVersion  = "V2.4"
  SecurityZone    = "A"
}

############################################################################################
########## IAM Assumable Role With OIDC for amazon-cloudwatch-observability Addons #########
############################################################################################
observability_addon_role_name = "ecom_Higher_Addon_Observability_Role"


#########################################
######### Cloudwatch Monitoring #########
#########################################
# sns_config = {
#     name = "ecom-errors-monitoring",
#     subscriptions = {
#       sqs1 = {
#         endpoint = "basma.kamal2@vodafone.com"
#         protocol = "email"
#       }
#     }
#   }
# metric_alarm_config = {
#     alarm_name          = "ecom-errors-monitoring"
#     alarm_description   = "This alarm triggers when ..... errors are detected"
#     comparison_operator = "GreaterThanOrEqualToThreshold"
#     evaluation_periods  = 1
#     threshold           = 1
#     period              = 10
#     unit                = "Count"
#     namespace           = "ecom/EKS/Logs"
#     statistic           = "SampleCount"
#     treat_missing_data  = "notBreaching"
#   }

##########################################
############### Network ##################
##########################################
cidr_vpc = "10.2.0.0/16"
tag_subnets_k8s_private = {
  Project                           = "ecom"
  Environment                       = "PROD"
  ManagedBy                         = "basma.kamal2@vodafone.com"
  Confidentiality                   = "C2"
  TaggingVersion                    = "V2.4"
  SecurityZone                      = "A"
  "kubernetes.io/role/internal-elb" = "1"
}
tag_subnets_k8s_public = {
  Project                  = "ecom"
  Environment              = "PROD"
  ManagedBy                = "basma.kamal2@vodafone.com"
  Confidentiality          = "C2"
  TaggingVersion           = "V2.4"
  SecurityZone             = "A"
  "kubernetes.io/role/elb" = "1"
}

##########################################
################# EKS ####################
##########################################
cluster_name           = "ecom"
cluster_version        = "1.31"
kms_key_administrators = ["arn:aws:iam::117521914691:role/Github-Runners-Access", "arn:aws:iam::117521914691:role/DevOps", "arn:aws:iam::117521914691:role/Administrator"]
cluster_endpoint_public_access_cidrs = [
  "34.241.8.32/32", "34.241.11.243/32", "34.251.16.179/32",                                                                     ## Runners IPs
  "62.68.247.20/32",                                                                                                            ## Egypt IP
  "212.18.162.33/32", "213.30.78.168/32", "213.30.78.169/32", "213.30.78.170/32", "213.30.78.171/32", "213.30.78.172/32",       ## Portugal IPs
  "81.12.134.70/32", "81.12.134.71/32", "81.12.134.72/32", "46.97.128.35/32",                                                   ## Romania IPs
  "194.62.232.101/32", "194.62.232.102/32", "194.62.232.103/32", "194.62.232.104/32", "194.62.232.109/32", "194.62.232.110/32", ## UK +VGSL IPs
  "102.221.68.0/22",                                                                                                            ## VOIS EG IP
]
eks_managed_node_groups = {
  "ecom_eu-west-1" = {
    desired_size               = 3
    min_size                   = 3
    max_size                   = 12
    use_custom_launch_template = true
    enable_bootstrap_user_data = true
    # ami_id                     = "ami-0c23fc62d8d822239"
    labels = {
      role = "ecom_eu-west-1"
    }
    instance_types = ["t3.xlarge"]
    capacity_type  = "ON_DEMAND"
    block_device_mappings = {
      xvda = {
        device_name = "/dev/xvda"
        ebs = {
          volume_size           = 60
          volume_type           = "gp2"
          iops                  = 0
          encrypted             = true
          delete_on_termination = true
        }
      }
    }
    taints = {}
    tags = {
      Project         = "ecom"
      Environment     = "PROD"
      ManagedBy       = "basma.kamal2@vodafone.com"
      Confidentiality = "C2"
      TaggingVersion  = "V2.4"
      SecurityZone    = "A"
    }
  }
}
access_entries = {
  Administrators = {
    principal_arn = "arn:aws:iam::117521914691:role/Administrator"
    policy_associations = {
      admin = {
        policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
        access_scope = {
          type = "cluster"
        }
      }
    }
  },
  DevOps = {
    principal_arn = "arn:aws:iam::117521914691:role/DevOps"
    policy_associations = {
      DevOps = {
        policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
        access_scope = {
          type = "cluster"
        }
      }
    }
  },
  Github-Runners-Access = {
    principal_arn = "arn:aws:iam::117521914691:role/Github-Runners-Access"
    policy_associations = {
      Github-Runners-Access = {
        policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
        access_scope = {
          type = "cluster"
        }
      }
    }
  }
}
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
  "stage" = {
    labels = {
      "pod-security.kubernetes.io/enforce" = "baseline"
      "pod-security.kubernetes.io/warn"    = "restricted"
    }
  },
  "prod" = {
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
