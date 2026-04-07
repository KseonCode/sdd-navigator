#!/bin/bash
# @req REQ-INFRA-008 Deterministic traceability checker

set -euo pipefail

# Переход в корень проекта
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_ROOT"

echo "🔍 Checking traceability annotations..."
echo "📂 Project root: $PROJECT_ROOT"
echo ""

FAILED=0

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Функция проверки файла на наличие @req в любом формате
check_annotation() {
    local file=$1
    # Ищем разные форматы @req:
    # - # @req (YAML, Dockerfile, shell)
    # - // @req (Rust, TypeScript)
    # - {{/* @req (Helm templates)
    # - <!-- @req (HTML)
    if grep -qE "(# @req|// @req|{{/\* @req|<!-- @req)" "$file"; then
        return 0
    else
        return 1
    fi
}

echo "📁 Checking Rust files..."
if [ -d "app/api/src" ]; then
    while IFS= read -r file; do
        if [ -z "$file" ]; then
            continue
        fi
        if ! check_annotation "$file"; then
            echo -e "${RED}❌ Missing @req annotation: $file${NC}"
            FAILED=1
        else
            echo -e "${GREEN}✅ $file${NC}"
        fi
    done < <(find app/api -name "*.rs" -type f -not -path "*/target/*" 2>/dev/null || true)
fi

echo ""
echo "📁 Checking Helm templates..."
if [ -d "helm" ]; then
    while IFS= read -r file; do
        if [ -z "$file" ]; then
            continue
        fi
        if [[ "$file" =~ (values.yaml|Chart.yaml|values-dev.yaml|values-staging.yaml)$ ]]; then
            continue
        fi
        if ! check_annotation "$file"; then
            echo -e "${RED}❌ Missing @req annotation: $file${NC}"
            FAILED=1
        else
            echo -e "${GREEN}✅ $file${NC}"
        fi
    done < <(find helm -name "*.yaml" -o -name "*.tpl" 2>/dev/null || true)
fi

echo ""
echo "📁 Checking Ansible files..."
if [ -d "ansible" ]; then
    while IFS= read -r file; do
        if [ -z "$file" ]; then
            continue
        fi
        if ! check_annotation "$file"; then
            echo -e "${RED}❌ Missing @req annotation: $file${NC}"
            FAILED=1
        else
            echo -e "${GREEN}✅ $file${NC}"
        fi
    done < <(find ansible -name "*.yml" -o -name "*.yaml" 2>/dev/null || true)
fi

echo ""
echo "📁 Checking Network Policies..."
if [ -d "helm" ]; then
    while IFS= read -r file; do
        if [ -z "$file" ]; then
            continue
        fi
        if ! check_annotation "$file"; then
            echo -e "${RED}❌ Missing @req annotation: $file${NC}"
            FAILED=1
        else
            echo -e "${GREEN}✅ $file${NC}"
        fi
    done < <(find helm -path "*/networking/*.yaml" 2>/dev/null || true)
fi

echo ""
echo "📁 Checking Dockerfiles..."
while IFS= read -r file; do
    if [ -z "$file" ]; then
        continue
    fi
    if ! check_annotation "$file"; then
        echo -e "${RED}❌ Missing @req annotation: $file${NC}"
        FAILED=1
    else
        echo -e "${GREEN}✅ $file${NC}"
    fi
done < <(find app -name "Dockerfile" 2>/dev/null || true)

echo ""
echo "📁 Checking docker-compose.yml..."
if [ -f "docker-compose.yml" ]; then
    if ! check_annotation "docker-compose.yml"; then
        echo -e "${RED}❌ Missing @req annotation: docker-compose.yml${NC}"
        FAILED=1
    else
        echo -e "${GREEN}✅ docker-compose.yml${NC}"
    fi
fi

echo ""
echo "========================================="
if [ $FAILED -eq 1 ]; then
    echo -e "${RED}❌ Traceability check failed${NC}"
    echo "========================================="
    exit 1
else
    echo -e "${GREEN}✅ All artifacts have @req annotations${NC}"
    echo "========================================="
    exit 0
fi