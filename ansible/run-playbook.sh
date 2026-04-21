#!/bin/bash
# run-playbook.sh - запуск Ansible playbook

# Проверяем аргументы
if [ "$1" == "--local" ]; then
    echo "🏠 Running playbook LOCALLY (no SSH)"
    INVENTORY="-i localhost,"
    EXTRA_ARGS="--connection=local"
elif [ "$1" == "--remote" ]; then
    echo "🌐 Running playbook REMOTELY (via SSH)"
    INVENTORY="-i inventory/hosts.ini"
    EXTRA_ARGS=""
else
    echo "Usage: ./run-playbook.sh [--local | --remote]"
    echo "  --local   - Run on local machine (no SSH)"
    echo "  --remote  - Run on remote host via SSH"
    echo ""
    echo "Example:"
    echo "  ./run-playbook.sh --local"
    echo "  ./run-playbook.sh --remote --ask-become-pass"
    exit 1
fi

echo "🚀 Starting Ansible playbook..."
echo "📅 Started at: $(date)"
echo ""

# Запуск playbook
time ansible-playbook $INVENTORY playbooks/site.yml $EXTRA_ARGS --ask-become-pass -v

echo ""
echo "✅ Playbook finished at: $(date)"
