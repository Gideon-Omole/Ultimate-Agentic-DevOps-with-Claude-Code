# S3 Backend for Terraform State
#
# INSTRUCTIONS:
# 1. First, run: terraform init
#    This will initialize Terraform with local state
#
# 2. Create the initial resources:
#    terraform apply
#
# 3. Once the S3 bucket and DynamoDB table are created, uncomment the
#    backend configuration below
#
# 4. Run: terraform init -migrate-state
#    This will migrate state from local to S3 backend
#
# terraform {
#   backend "s3" {
#     bucket         = "terraform-state-bucket-name"
#     key            = "portfolio-site/terraform.tfstate"
#     region         = "ap-south-1"
#     encrypt        = true
#     dynamodb_table = "terraform-locks"
#   }
# }
