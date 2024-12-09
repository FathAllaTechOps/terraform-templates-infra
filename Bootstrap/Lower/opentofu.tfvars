infra_bucket_name = "${project_name}-lower-tfstate-file"
dynamodb_name = "${project_name}-lower-tfstate-lock"
tags = {
      Project         = "${project_name}"
      Environment     = "Dev"
      ManagedBy       = "${managed_by}"
      Confidentiality = "C2"
      TaggingVersion  = "V2.4"
      SecurityZone    = "A"
}