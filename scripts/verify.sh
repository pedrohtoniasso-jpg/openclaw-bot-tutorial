#!/usr/bin/env bash
set -euo pipefail

required_files=(
  README.md
  docs/00-bootstrap-completo.md
  docs/01-visao-geral.md
  docs/02-instalacao.md
  docs/03-funcionalidades.md
  docs/04-skills.md
  docs/05-crons.md
  configs/openclaw.replica.example.json
  skills/replica-assistant/SKILL.md
  scripts/setup-replica.sh
)

required_skills=(
  brainstorming
  cerebro
  dispatching-parallel-agents
  executing-plans
  finishing-a-development-branch
  gog
  moltbook-interact
  openclaw-cron-authoring
  receiving-code-review
  requesting-code-review
  replica-assistant
  safety-check
  subagent-driven-development
  systematic-debugging
  test-driven-development
  using-git-worktrees
  using-superpowers
  verification-before-completion
  whatsapp-context-ingestion
  writing-plans
  writing-skills
)

for path in "${required_files[@]}"; do
  test -f "$path" || { echo "missing $path"; exit 1; }
done

for skill in "${required_skills[@]}"; do
  test -f "skills/$skill/SKILL.md" || { echo "missing skill $skill"; exit 1; }
done

bash -n scripts/setup-replica.sh

awk 'BEGIN{n=0} /^```/{n++} END{if(n%2){print "unbalanced markdown fences"; exit 1}}' README.md docs/*.md examples/*.md

if grep -RInE --exclude='verify.sh' '023\.|GB[0-9]|99626|99901|8532357089|toniasso@|hotmail|CPF|Passaporte|Oracle-hosted|Oracle Free Tier VPS' README.md docs skills templates examples configs scripts >/tmp/openclaw-bot-tutorial-private-scan.txt; then
  cat /tmp/openclaw-bot-tutorial-private-scan.txt
  echo "possible private data found"
  exit 1
fi

echo "ok"
