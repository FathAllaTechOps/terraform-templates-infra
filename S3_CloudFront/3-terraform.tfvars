##################################################
########## S3 Buckets And CloudFront  ############
##################################################
rules = {
  "keep-latest-version" = {
    status = "Enabled"

    noncurrent_version_expiration = {
      newer_noncurrent_versions = 13
      noncurrent_days           = 31
    }
    noncurrent_version_transition = {
      newer_noncurrent_versions = 1
      noncurrent_days           = 30
      storage_class             = "STANDARD_IA"
    }
    abort_incomplete_multipart_upload = {
      days_after_initiation = 1
    }
  }
}
alt_domain_names    = ["dev.${domain_name}", "sit.${domain_name}"]
