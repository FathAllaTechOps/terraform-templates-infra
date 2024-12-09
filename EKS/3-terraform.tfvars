##########################################
################# EKS ####################
##########################################
cluster_name           = ${cluster_name}
cluster_version        = ${cluster_version}
kms_key_administrators = ["arn:aws:iam::${aws_account_id}:role/Github-Runners-Access", "arn:aws:iam::${aws_account_id}:role/DevOps", "arn:aws:iam::${aws_account_id}:role/Administrator"]
cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
eks_managed_node_groups = {
  "${project_name}_${aws_region}" = {
    desired_size               = 2
    min_size                   = 2
    max_size                   = 5
    use_custom_launch_template = true
    enable_bootstrap_user_data = true
    # ami_id                     = "ami-07ade57ebecc712e6"
    labels = {
      role = "${project_name}_${aws_region}"
    }
    instance_types = ["t3.medium"]
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
      Project         = "${project_name}"
      Environment     = "Dev"
      ManagedBy       = "${managed_by}"
      Confidentiality = "C2"
      TaggingVersion  = "V2.4"
      SecurityZone    = "A"
    }
    create_schedule = true
    schedules = {
      "scale_down_weekend" = {
        min_size     = 0
        max_size     = 1
        desired_size = 0
        time_zone    = "UTC"
        recurrence   = "0 0 * * 6,0" # Every Saturday and Sunday at 00:00
      },
      "scale_down_after_hours" = {
        min_size     = 0
        max_size     = 1
        desired_size = 0
        time_zone    = "UTC"
        recurrence   = "0 18 * * 1-5" # Every weekday starting at 18:00
      },
      "scale_up_working_hours" = {
        min_size     = 3
        max_size     = 15
        desired_size = 3
        time_zone    = "UTC"
        recurrence   = "0 6 * * 1-5" # Every weekday starting at 06:00
      }
    }
  }
}
access_entries = {
  Administrators = {
    principal_arn = "arn:aws:iam::${aws_account_id}:role/Administrator"
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
    principal_arn = "arn:aws:iam::${aws_account_id}:role/DevOps"
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
    principal_arn = "arn:aws:iam::${aws_account_id}:role/Github-Runners-Access"
    policy_associations = {
      Github-Runners-Access = {
        policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
        access_scope = {
          type = "cluster"
        }
      }
    }
  },
  Developer = {
    principal_arn = "arn:aws:iam::${aws_account_id}:role/Developer"
    policy_associations = {
      Developer = {
        policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
        access_scope = {
          type = "cluster"
        }
      }
    }
  }
}
