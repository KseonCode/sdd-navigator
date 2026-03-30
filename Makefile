# @req REQ-INFRA-007 Makefile for deterministic local validation
.PHONY: help lint-api lint-web lint-helm lint-ansible test-all

help:
	@echo "Targets:"
	@echo "  lint-api      - Run Rust linter and formatter"
	@echo "  lint-web      - Run Next.js linter and typecheck"
	@echo "  lint-helm     - Validate Helm charts"
	@echo "  lint-ansible  - Validate Ansible playbooks"
	@echo "  test-all      - Run all validation scripts"

lint-api:
	cd app/api && cargo fmt --check && cargo clippy -- -D warnings

lint-web:
	cd app/web && npm run lint && npx tsc --noEmit

lint-helm:
	helm lint helm/sdd-navigator
	helm template helm/sdd-navigator | kubeconform --strict -summary

lint-ansible:
	ansible-lint ansible/playbooks/*.yml --exclude=ansible/roles
	ansible-playbook ansible/playbooks/deploy-k3s.yml --syntax-check
	ansible-playbook ansible/playbooks/deploy-app.yml --syntax-check

test-all: lint-api lint-web lint-helm lint-ansible
	./scripts/check_traceability.sh
