#!/bin/bash
# PostToolUse hook — logs Terraform and AWS commands

INPUT=$(cat)
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

LOG_FILE="$CLAUDE_PROJECT_DIR/.claude/deploy.log"
mkdir -p "$(dirname "$LOG_FILE")"

if echo "$CMD" | grep -qE "terraform (init|plan|apply|fmt|validate|output|show)|aws (s3|cloudfront|sts)"; then
  echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] Command executed: $CMD" >> "$LOG_FILE"
fi