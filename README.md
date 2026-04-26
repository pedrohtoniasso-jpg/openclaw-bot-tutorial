# OpenClaw Bot Tutorial — agente estilo Claw, sem memórias privadas

Este repositório ensina a configurar um agente OpenClaw parecido com a Claw: direto, operacional, com skills, tools, cron, browser e automações — mas começando limpo, sem `MEMORY.md`, histórico pessoal, WhatsApp, decisões antigas ou conhecimento privado do Pedro.

O objetivo é montar uma **réplica funcional**, não uma cópia da identidade/memória.

## Como usar

1. Leia `docs/01-visao-geral.md`.
2. Rode `scripts/setup-replica.sh`.
3. Escolha quais funcionalidades quer habilitar.
4. Copie os arquivos gerados para o workspace do novo agente.
5. Valide com `scripts/verify.sh`.

## Estrutura

- `docs/` — passo a passo completo
- `configs/` — exemplos de `openclaw.json`
- `skills/` — skill base de comportamento e operação
- `templates/` — `AGENTS.md`, `SOUL.md`, `USER.md`, `TOOLS.md`, `HEARTBEAT.md`
- `scripts/` — assistente interativo de configuração
- `memory/` — intencionalmente quase vazio; ponto de partida limpo
- `examples/` — exemplos de prompts, crons e fluxos

## Princípio de segurança

Não copie memórias privadas, credenciais, chats, WhatsApp, `MEMORY.md` real, logs pessoais ou contexto do usuário original. Este tutorial cria um agente novo, sem passado.
