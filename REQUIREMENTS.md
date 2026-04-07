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

# Security Requirements

## REQ-SEC-001: Default deny all ingress
All ingress traffic MUST be denied by default. Only explicitly allowed traffic is permitted.

## REQ-SEC-002: Zero-trust network policy
Network policies MUST implement zero-trust security model with least privilege access.

## REQ-SEC-003: API to PostgreSQL isolation
Only API pods MUST be able to access PostgreSQL database on port 5432.

## REQ-SEC-004: Frontend to API isolation
Only frontend pods MUST be able to access API service on port 8080.

## REQ-SEC-005: External ingress access
Only Ingress controller MUST be able to access frontend service on port 3000.

## REQ-SEC-006: DNS resolution for service discovery
All pods MUST be able to resolve DNS for internal service discovery (CoreDNS/kube-dns).