#!/bin/bash

# API Test

API_URL="http://localhost:8080"

echo "========================================"
echo "   SDD NAVIGATOR API TEST"
echo "========================================"
echo ""
echo "📍 API URL: $API_URL"
echo ""

# 1. Root endpoint
echo -n "1. GET /: "
curl -s "$API_URL/"
echo ""

# 2. Health check
echo -n "2. GET /health: "
curl -s "$API_URL/health"
echo ""

# 3. Liveness probe
echo -n "3. GET /health/live: "
curl -s "$API_URL/health/live"
echo ""

# 4. Readiness probe
echo -n "4. GET /health/ready: "
curl -s "$API_URL/health/ready"
echo ""

echo ""
echo "========================================"
echo "   TEST COMPLETED"
echo "========================================"