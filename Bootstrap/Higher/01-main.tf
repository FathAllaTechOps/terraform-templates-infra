module "bootstrap" {
  # checkov:skip=CKV_TF_1: ADD REASON
  source                  = "github.com/VFGroup-VBIT/vbitdc-terraform-module-infra.git//Bootstrap?ref=v1.8.1"
  infra_bucket_name       = var.infra_bucket_name
  dynamodb_name           = var.dynamodb_name
  tags                    = var.tags
}

resource "null_resource" "create_local_file" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = <<-EOT
      echo 'bucket         = "${module.bootstrap.Infra_Bukcet_name}"' > ../../Higher_backend.hcl
      echo 'region         = "${module.bootstrap.region}"' >> ../../Higher_backend.hcl
      echo 'key            = "terraform.tfstate"' >> ../../Higher_backend.hcl
      echo 'dynamodb_table = "${module.bootstrap.DynamoDB_name}"' >> ../../Higher_backend.hcl
    EOT
  }
  depends_on = [ module.bootstrap ]
}