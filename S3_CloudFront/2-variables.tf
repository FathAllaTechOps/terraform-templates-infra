##################################################
########## S3 Buckets And CloudFront  ############
##################################################
variable "rules" {
  type = map(object({
    status = string
    noncurrent_version_expiration = optional(object({
      newer_noncurrent_versions = number #Number of noncurrent versions Amazon S3 will retain. Must be a non-zero positive integer.
      noncurrent_days           = number #Number of days an object is noncurrent before Amazon S3 can perform the associated action. Must be a positive integer
    }))
    noncurrent_version_transition = optional(object({
      newer_noncurrent_versions = number # Number of noncurrent versions Amazon S3 will retain. Must be a non-zero positive integer
      noncurrent_days           = number # Number of days an object is noncurrent before Amazon S3 can perform the associated action.
      storage_class             = string # Class of storage used to store the object. Valid Values: GLACIER, STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, DEEP_ARCHIVE, GLACIER_IR
    }))
    abort_incomplete_multipart_upload = optional(object({
      days_after_initiation = number #Number of days after which Amazon S3 aborts an incomplete multipart upload.
    }))
  }))
  default = {}
}
variable "alt_domain_names" {
  type = list(any)
}