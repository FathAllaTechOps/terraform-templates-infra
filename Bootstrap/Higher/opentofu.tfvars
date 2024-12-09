infra_bucket_name = "${project_name}-higher-tfstate-file"
dynamodb_name = "${project_name}-higher-tfstate-lock"
tags = {
      Project         = "${project_name}"
      Environment     = "Prod"
      ManagedBy       = "${managed_by}"
      Confidentiality = "C2"
      TaggingVersion  = "V2.4"
      SecurityZone    = "A"
}