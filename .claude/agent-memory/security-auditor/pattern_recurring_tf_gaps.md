---
name: pattern-recurring-tf-gaps
description: Specific security controls missing from terraform/main.tf as of 2026-07-06 audit — check on re-audit whether fixed
metadata:
  type: project
---

As of the 2026-07-06 audit, `terraform/main.tf` gets the fundamentals right (S3 fully blocked
from public access, CloudFront OAC with SourceArn-scoped bucket policy, HTTPS redirect,
versioning enabled) but is missing:

- No `aws_s3_bucket_server_side_encryption_configuration` (no encryption-at-rest control set).
- No `aws_s3_bucket_logging` (no access logging on the site bucket).
- No CloudFront `logging_config` block (no CDN access logs).
- No `aws_cloudfront_response_headers_policy` attached to `default_cache_behavior` (no CSP,
  X-Frame-Options, HSTS, etc.).
- No `aws_s3_bucket_ownership_controls` (BucketOwnerEnforced) — ACLs not explicitly disabled.
- `backend.tf` ships with the S3/DynamoDB backend block commented out — state is local by
  default (no encryption, no locking) until someone manually uncomments it post-bootstrap.
- `viewer_certificate` uses `cloudfront_default_certificate` only; `domain_name` variable is
  defined but unused — if a custom domain is ever wired up, must add ACM cert + explicitly set
  `minimum_protocol_version = "TLSv1.2_2021"`.

**Why tracked here:** These are low-effort, high-value fixes that keep recurring across audits
of this specific file. Re-check this exact list first on future audits rather than re-deriving
from scratch — only report as new/notable if the gap has actually changed.

**How to apply:** When re-auditing `terraform/main.tf`, diff against this list before reporting.
Related: [[project-portfolio-infra]] for the IAM/workflow-side gaps.
