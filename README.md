# OpenClaw Bot Tutorial — agente estilo Claw, sem memórias privadas

Este repositório ensina a configurar um agente OpenClaw parecido com a Claw: direto, operacional, com skills, tools, cron, browser e automações — mas começando limpo, sem `MEMORY.md`, histórico pessoal, WhatsApp, decisões antigas ou conhecimento privado do usuário original.

O objetivo é montar uma **réplica funcional**, não uma cópia da identidade/memória.

## Caminho rápido

```bash
curl -fsSL https://openclaw.ai/install.sh | bash
openclaw --version
openclaw doctor

git clone https://github.com/pedrohtoniasso-jpg/openclaw-bot-tutorial.git
cd openclaw-bot-tutorial
bash scripts/setup-replica.sh
bash scripts/verify.sh
```

Depois abra uma conversa com o agente e envie o prompt de bootstrap em `docs/00-bootstrap-completo.md`.

## Estrutura

- `docs/00-bootstrap-completo.md` — passo a passo completo: instalar OpenClaw, instalar skills, prompt inicial, crons, heartbeat e backup.
- `docs/01-visao-geral.md` — visão geral do projeto.
- `docs/02-instalacao.md` — instalação base.
- `docs/03-funcionalidades.md` — funcionalidades opcionais.
- `docs/04-skills.md` — skills incluídas e como instalar.
- `docs/05-crons.md` — crons principais: daily check, backup/update, Moltbook, otimização semanal e saúde dos crons.
- `configs/` — exemplos de `openclaw.json`.
- `skills/` — skills reutilizáveis incluídas neste tutorial.
- `templates/` — `AGENTS.md`, `SOUL.md`, `USER.md`, `TOOLS.md`, `HEARTBEAT.md`.
- `scripts/` — assistente interativo de configuração e verificação.
- `memory/` — intencionalmente quase vazio; ponto de partida limpo.
- `examples/` — exemplos de prompts, crons e fluxos.

## Skills incluídas

Inclui skills genéricas de operação, segurança, desenvolvimento, segundo cérebro, Gog e Moltbook. Não inclui skills específicas da infraestrutura privada original.

Veja `docs/04-skills.md`.

## Crons incluídos

O tutorial documenta os principais crons usados no agente:

- backup/update diário;
- daily check / revisão de atividades;
- radar semanal Moltbook;
- otimização semanal do OpenClaw;
- relatório semanal de saúde dos crons.

Veja `docs/05-crons.md`.

## Princípio de segurança

Não copie memórias privadas, credenciais, chats, WhatsApp, `MEMORY.md` real, logs pessoais ou contexto do usuário original. Este tutorial cria um agente novo, sem passado.
