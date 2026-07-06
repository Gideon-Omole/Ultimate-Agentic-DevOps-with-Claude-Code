---
name: project-portfolio-infra
description: Architecture and known gaps in this repo's S3+CloudFront portfolio site Terraform, as of first audit 2026-07-06
metadata:
  type: project
---

Infra is a static HTML/CSS portfolio site: S3 bucket (private, OAC-fronted) + CloudFront + GitHub
Actions OIDC deploy. All defined in `terraform/main.tf`, `providers.tf`, `variables.tf`,
`outputs.tf`, `backend.tf`. No `terraform/iam.tf` or similar exists — no IAM resources are
defined in Terraform at all.

**Why this matters:** The GitHub Actions deploy role (`arn:aws:iam::533267262133:role/github-actions-deploy`)
is hardcoded directly in `.github/workflows/deploy.yml` (role ARN, S3 bucket name
`pravinmishradmi-site-production`, and CloudFront distribution ID `E3V6O6MRE2E21P` are all
hardcoded there, not sourced from Terraform outputs or repo secrets). This means:
1. The IAM role/OIDC trust policy is unmanaged by Terraform — cannot verify least privilege or
   repo/branch scoping from code, and it violates the project's own CLAUDE.md convention
   ("All infrastructure changes go through Terraform — never modify AWS resources manually").
2. Hardcoded AWS account ID + resource identifiers live in versioned workflow YAML.

**How to apply:** On every audit, check `.github/workflows/*.yml` in addition to `terraform/`
for hardcoded ARNs/account IDs/bucket names, and flag the missing `aws_iam_role` /
`aws_iam_openid_connect_provider` Terraform resources as a standing finding until remediated.
See [[pattern_recurring_tf_gaps]] for the specific missing controls found in `terraform/main.tf`.
