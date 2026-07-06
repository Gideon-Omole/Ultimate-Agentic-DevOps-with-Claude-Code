---
name: s3-versioning-cost-issue
description: S3 versioning enabled on portfolio bucket, storing all historical versions increasing storage costs
metadata:
  type: project
---

**Issue:** S3 bucket has versioning enabled (terraform/main.tf lines 10-15) which stores multiple versions of every uploaded object.

**Why:** For a static portfolio website, version history is unnecessary and adds 100% storage overhead per version retained. For a site with 10-100 objects updated occasionally, this could result in 10-50x storage multiplier.

**How to apply:** Disable versioning unless the project requires rollback capability for HTML/CSS changes.

**Estimated impact:** LOW (portfolio sites are typically <50MB), but principle applies to any S3-backed project.
