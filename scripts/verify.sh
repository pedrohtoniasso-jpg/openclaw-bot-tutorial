#!/usr/bin/env bash
set -euo pipefail
for path in README.md docs/01-visao-geral.md configs/openclaw.replica.example.json skills/replica-assistant/SKILL.md scripts/setup-replica.sh; do
  test -f "$path" || { echo "missing $path"; exit 1; }
done
bash -n scripts/setup-replica.sh
echo "ok"
