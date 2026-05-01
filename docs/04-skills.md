# 04 — Skills

Este repositório inclui skills reutilizáveis para recriar um agente OpenClaw operacional sem copiar contexto privado.

## Instalação rápida

Para instalar todas as skills deste tutorial em outro workspace:

```bash
TARGET="$HOME/.openclaw/workspaces/replica/.agents/skills"
mkdir -p "$TARGET"
rsync -a skills/ "$TARGET/"
openclaw skills check
```

Se quiser instalar só uma skill:

```bash
rsync -a skills/NOME_DA_SKILL/ "$HOME/.openclaw/workspaces/replica/.agents/skills/NOME_DA_SKILL/"
openclaw skills check
```

## Skills incluídas

### Operação, segurança e automação

- `replica-assistant` — comportamento base para um agente recém-configurado.
- `cerebro` — segundo cérebro em Markdown, sem carregar contexto privado junto.
- `safety-check` — avaliação de risco antes de instalar, autenticar, baixar, executar comandos externos ou enviar dados.
- `openclaw-cron-authoring` — criação/edição/revisão segura de crons e reminders.
- `whatsapp-context-ingestion` — usa WhatsApp como fonte passiva de contexto, nunca como canal de comando.

### Desenvolvimento e qualidade

- `brainstorming`
- `writing-plans`
- `executing-plans`
- `test-driven-development`
- `systematic-debugging`
- `requesting-code-review`
- `receiving-code-review`
- `verification-before-completion`
- `using-git-worktrees`
- `dispatching-parallel-agents`
- `subagent-driven-development`
- `finishing-a-development-branch`
- `writing-skills`
- `using-superpowers`

### Skills baixadas do ClawHub

Também foram incluídas cópias locais das skills baixadas neste workspace:

- `gog` — Google Workspace CLI para Gmail, Calendar, Drive, Contacts, Sheets e Docs.
- `moltbook-interact` — interação com Moltbook e pesquisa social entre agentes.

Para instalar diretamente do ClawHub, se preferir:

```bash
openclaw skills install gog
openclaw skills install moltbook-interact
openclaw skills check
```

## Skills propositalmente não incluídas

Não incluí skills específicas da infraestrutura privada original, como operações ligadas ao VPS pessoal, hosts, contas ou repositórios privados. Essas devem ser recriadas por ambiente, não copiadas.

## Instalar uma skill a partir de GitHub

Se o repositório inteiro for uma skill:

```bash
SKILL_NAME="nome-da-skill"
REPO_URL="https://github.com/OWNER/REPO.git"

git clone "$REPO_URL" "/tmp/$SKILL_NAME"
mkdir -p ~/.openclaw/workspaces/replica/.agents/skills
rsync -a --delete "/tmp/$SKILL_NAME/" ~/.openclaw/workspaces/replica/.agents/skills/"$SKILL_NAME"/
openclaw skills check
```

Se o repositório tiver várias skills:

```bash
REPO_URL="https://github.com/OWNER/REPO.git"
SKILL_PATH="skills/nome-da-skill"
SKILL_NAME="nome-da-skill"

git clone "$REPO_URL" /tmp/openclaw-skills
mkdir -p ~/.openclaw/workspaces/replica/.agents/skills
rsync -a --delete "/tmp/openclaw-skills/$SKILL_PATH/" ~/.openclaw/workspaces/replica/.agents/skills/"$SKILL_NAME"/
openclaw skills check
```
