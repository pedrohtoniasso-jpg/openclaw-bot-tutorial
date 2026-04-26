# 02 — Instalação base

```bash
npm install -g openclaw
openclaw configure
openclaw gateway start
openclaw gateway status
```

Crie um workspace limpo:

```bash
mkdir -p ~/.openclaw/workspaces/replica
cd ~/.openclaw/workspaces/replica
```

Copie os templates deste repo para o workspace:

```bash
cp templates/* ~/.openclaw/workspaces/replica/
mkdir -p ~/.openclaw/workspaces/replica/.agents/skills
cp -R skills/* ~/.openclaw/workspaces/replica/.agents/skills/
```
