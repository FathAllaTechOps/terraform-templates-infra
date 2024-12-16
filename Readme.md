# Terraform Infrastructure Generation

This repository contains scripts and workflows to generate Terraform infrastructure based on selected modules and provided AWS details.

## How to Trigger the Workflow

You can trigger the GitHub Actions workflow manually using the `workflow_dispatch` event. Follow the steps below to trigger the workflow:


### Using GitHub Web Interface

1. Go to the Actions tab in your GitHub repository.
2. Select the "Generate Infrastructure" workflow from the list of workflows.
3. Click on the "Run workflow" button.
4. Fill in the required inputs:
   - **S3_CloudFront**: Include S3_CloudFront module (boolean).
   - **Network**: Include Network module (boolean).
   - **EKS_Config**: Include EKS_Config module (boolean).
   - **EKS**: Include EKS module (boolean).
   - **aws_details**: AWS details in JSON format. Example:
     ```json
     {
       "aws_account_id": "123456789012",
       "project_name": "MyProject",
       "managed_by": "Terraform",
       "aws_region": "eu-west-1",
       "vpc_cidr_range": "10.1.0.0/16",
       "cluster_name": "MyCluster",
       "cluster_version": "1.31",
       "eks_instance_type": "t3.medium",
       "domain_name": "example.com"
     }
     ```
5. Click on the "Run workflow" button to start the workflow.

### Using GitHub CLI

You can also trigger the workflow using the GitHub CLI. Here is an example command:

```sh
gh workflow run main.yml --repo VFGroup-VBIT/vbitdc-repository-template-infra --ref development \
  --field S3_CloudFront=true \
  --field Network=true \
  --field EKS_Config=false \
  --field EKS=true \
  --field aws_details='{
    "aws_account_id": "123456789012",
    "project_name": "MyProject",
    "managed_by": "Terraform",
    "aws_region": "eu-west-1",
    "vpc_cidr_range": "10.1.0.0/16",
    "cluster_name": "MyCluster",
    "cluster_version": "1.31",
    "eks_instance_type": "t3.medium",
    "domain_name": "example.com"
  }'
```