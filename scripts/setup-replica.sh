#!/usr/bin/env bash
set -euo pipefail

read -rp "Workspace do novo agente [~/.openclaw/workspaces/replica]: " WORKSPACE
WORKSPACE=${WORKSPACE:-~/.openclaw/workspaces/replica}
WORKSPACE=${WORKSPACE/#\~/$HOME}
mkdir -p "$WORKSPACE/.agents/skills" "$WORKSPACE/memory"

cat <<MENU

Quais funcionalidades habilitar?
Digite números separados por vírgula.

1 browser
2 cron
3 gateway
4 message
5 tts
6 nodes
7 canvas
8 memory-wiki
9 comfy
10 web_search/x_search
11 code_execution
MENU
read -rp "Escolha: " CHOICES

ALLOW=(browser message gateway tts)
PLUGINS='"browser": { "enabled": true }, "memory-core": { "config": { "dreaming": { "enabled": true } } }'

case ",$CHOICES," in *,6,*) ALLOW+=(nodes);; esac
case ",$CHOICES," in *,7,*) ALLOW+=(canvas);; esac
case ",$CHOICES," in *,8,*) PLUGINS="$PLUGINS, \"memory-wiki\": { \"enabled\": true }";; esac
case ",$CHOICES," in *,9,*) PLUGINS="$PLUGINS, \"comfy\": { \"enabled\": true }";; esac

ALLOW_JSON=$(printf '"%s",' "${ALLOW[@]}" | sed 's/,$//')

cp templates/AGENTS.md templates/SOUL.md templates/USER.md templates/TOOLS.md templates/HEARTBEAT.md "$WORKSPACE/"
cp -R skills/* "$WORKSPACE/.agents/skills/"

cat > "$WORKSPACE/openclaw.replica.generated.json" <<JSON
{
  "agents": {
    "defaults": {
      "workspace": "$WORKSPACE",
      "model": {
        "primary": "openai-codex/gpt-5.5",
        "fallbacks": ["openai-codex/gpt-5.3-codex", "openrouter/auto"]
      }
    }
  },
  "tools": {
    "profile": "coding",
    "alsoAllow": [$ALLOW_JSON]
  },
  "plugins": {
    "entries": { $PLUGINS }
  }
}
JSON

echo "Gerado em $WORKSPACE"
echo "Revise $WORKSPACE/openclaw.replica.generated.json e mescle no ~/.openclaw/openclaw.json"
