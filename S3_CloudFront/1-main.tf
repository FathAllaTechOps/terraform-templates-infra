##################################################
########## S3 Buckets And CloudFront  ############
##################################################
module "s3_and_cloudfront_lower" {
  count                          = var.env == "dev" ? 1 : 0
  source                         = "github.com/VFGroup-VBIT/vbitdc-terraform-module-infra.git//S3_CloudFront?ref=v1.8.2"
  project_name                   = var.project_name
  tags                           = var.tags
  rules                          = var.rules
  attach_elb_log_delivery_policy = true
  s3_bucket = [
    {
      name = "dev-${project_name}"
      logging_config = [{
        include_cookies = true
        prefix          = "cf-logs"
      }]
      default_cache_behavior = {
        cache_policy_id            = "CachingOptimized"
        response_headers_policy_id = "SecurityHeadersPolicy"
        function_association = [
          {
            function_arn = module.cloudfront_functions.function_arns[0]
            event_type   = module.cloudfront_functions.function_event_types[0]
          }
        ]
      }
      viewer_certificate = {
        acm_certificate_arn      = module.dev_acm_us_east_1[0].acm_certificate_arn
        minimum_protocol_version = "TLSv1.2_2021"
        ssl_support_method       = "sni-only"
        aliases                  = [var.alt_domain_names[0]]
      }

    },
    {
      name = "sit-${project_name}"
      default_cache_behavior = {
        cache_policy_id            = "CachingOptimized"
        response_headers_policy_id = "SecurityHeadersPolicy"
        function_association = [
          {
            function_arn = module.cloudfront_functions.function_arns[0]
            event_type   = module.cloudfront_functions.function_event_types[0]
          }
        ]
      }
      viewer_certificate = {
        acm_certificate_arn      = module.sit_acm_us_east_1[0].acm_certificate_arn
        minimum_protocol_version = "TLSv1.2_2021"
        ssl_support_method       = "sni-only"
        aliases                  = [var.alt_domain_names[1]]
      }

    }
  ]
  providers = {
    aws                 = aws
    aws.failover_region = aws.failover_region
  }
}

##################################################
############ CloudFront Functions ################
##################################################
module "cloudfront_functions" {
  source               = "github.com/VFGroup-VBIT/vbitdc-terraform-module-infra.git//CloudFront_Function?ref=v1.8.2"
  cloudfront_functions = var.cloudfront_functions
}

######################
### ACM US-EAST-1 ####
######################
###########
### DEV ###
###########
data "aws_route53_zone" "dev" {
  name         = "dev.${domain_name}"
}
module "dev_acm_us_east_1" {
  count   = var.env == "dev" ? 1 : 0
  source  = "terraform-aws-modules/acm/aws"
  version = "4.0"

  domain_name = "dev.${domain_name}"
  zone_id     = data.aws_route53_zone.dev.zone_id

  validation_method = "DNS"

  subject_alternative_names = [
    "*.dev.${domain_name}",
  ]

  wait_for_validation = true

  tags = var.tags
  providers = {
    aws = aws.us-east-1
  }
}

###########
### SIT ###
###########
data "aws_route53_zone" "sit" {
  name         = "sit.${domain_name}"
}
module "sit_acm_us_east_1" {
  count   = var.env == "dev" ? 1 : 0
  source  = "terraform-aws-modules/acm/aws"
  version = "4.0"

  domain_name = "sit.${domain_name}"
  zone_id     = data.aws_route53_zone.sit.zone_id

  validation_method = "DNS"

  subject_alternative_names = [
    "*.sit.${domain_name}",
  ]

  wait_for_validation = true

  tags = var.tags
  providers = {
    aws = aws.us-east-1
  }
}