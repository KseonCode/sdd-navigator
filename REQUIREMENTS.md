# SDD Navigator Requirements
# @req REQ-INFRA-001 Root requirements document

## REQ-INFRA-001: Deploy SDD Navigator stack on K8s
Deploy complete application stack (Rust API, PostgreSQL, Next.js frontend) to Kubernetes using Helm and Ansible.

## REQ-INFRA-002: API health endpoint
Rust API MUST expose `/health` endpoint returning database connectivity status.

## REQ-INFRA-003: PostgreSQL StatefulSet
Database MUST run as StatefulSet with PersistentVolume for data persistence.

## REQ-INFRA-004: Frontend Ingress
Next.js frontend MUST be accessible via Kubernetes Ingress.

## REQ-INFRA-005: Helm parameterization
Helm charts MUST support multiple environments (dev/staging) via values files.

## REQ-INFRA-006: Ansible VM provisioning
Ansible MUST configure target VM with k3s and container runtime.

## REQ-INFRA-007: CI validation
CI pipeline MUST validate Helm charts and Ansible roles automatically.

## REQ-INFRA-008: Annotation coverage
CI MUST verify infrastructure code has @req annotations linking to requirements.
