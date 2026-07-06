---
name: cloudfront-price-class-optimization
description: CloudFront using PriceClass_200 instead of PriceClass_100 for static portfolio site
metadata:
  type: project
---

**Issue:** CloudFront distribution configured with `price_class = "PriceClass_200"` (terraform/main.tf line 62).

**Why:** PriceClass_200 includes ~200 global edge locations. For a portfolio website, PriceClass_100 (using only US, Europe, and Asia-Pacific edge locations) is sufficient and costs ~30-40% less while maintaining good global coverage for most users.

**How to apply:** Change price_class from "PriceClass_200" to "PriceClass_100" for cost reduction without meaningful performance degradation for static content.

**Estimated impact:** MEDIUM (relative to project size) — for typical portfolio traffic, could save $0.50-$2/month depending on data transfer volume.
