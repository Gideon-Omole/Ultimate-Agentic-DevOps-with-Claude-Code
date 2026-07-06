---
name: cache-policy-configuration
description: CloudFront using Managed-CachingOptimized policy for static assets
metadata:
  type: project
---

**Configuration:** CloudFront uses AWS Managed Cache Policy "Managed-CachingOptimized" (terraform/main.tf line 75).

**Notes:** This policy applies reasonable defaults (24-hour TTL for static assets, compression enabled), which is appropriate for static portfolios. The configuration is cost-efficient — fewer cache misses = fewer origin requests = lower bandwidth costs from S3.

**Current optimization level:** GOOD. The managed policy follows AWS best practices. Manual TTL tuning would provide minimal additional savings for a static site.

**Related:** [[cloudfront-price-class-optimization]]
