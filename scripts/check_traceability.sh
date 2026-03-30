#!/bin/bash
# @req REQ-INFRA-008 Deterministic traceability checker
# Fails if any code artifact lacks @req annotation

set -euo pipefail

echo "🔍 Checking traceability annotations..."

FAILED=0

# Check Rust files
while IFS= read -r file; do
    if ! grep -q "@req REQ-INFRA-" "$file"; then
        echo "❌ Missing @req annotation: $file"
        FAILED=1
    fi
done < <(find app/api -name "*.rs" -type f 2>/dev/null || true)

# Check Helm templates
while IFS= read -r file; do
    if ! grep -q "# @req REQ-INFRA-" "$file"; then
        echo "❌ Missing @req annotation: $file"
        FAILED=1
    fi
done < <(find helm -name "*.yaml" -o -name "*.tpl" | grep -v "values.yaml" 2>/dev/null || true)

# Check Ansible files
while IFS= read -r file; do
    if ! grep -q "# @req REQ-INFRA-" "$file"; then
        echo "❌ Missing @req annotation: $file"
        FAILED=1
    fi
done < <(find ansible -name "*.yml" -o -name "*.yaml" 2>/dev/null || true)

if [ $FAILED -eq 1 ]; then
    echo "❌ Traceability check failed"
    exit 1
fi

echo "✅ All artifacts have @req annotations"
