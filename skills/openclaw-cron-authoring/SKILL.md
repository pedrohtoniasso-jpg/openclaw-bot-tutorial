---
name: openclaw-cron-authoring
description: Use when creating, editing, removing, or verifying OpenClaw cron jobs, reminders, or scheduled follow-ups, especially when delivery target, timezone, silence rules, duplicate avoidance, or cross-cron coordination could be easy to get wrong.
---

# OpenClaw Cron Authoring

## Overview
Cron no OpenClaw é simples até tu errar um detalhe e mandar a mensagem no lugar errado, duplicar job, ou agendar no fuso errado.

A regra: **inspeciona antes, cria/edita com delivery explícito, verifica depois**.

## Quando usar
- criar lembrete one-shot
- criar rotina recorrente
- editar cron existente
- jobs com `NO_REPLY`
- jobs que avisam só em certa condição
- jobs que cancelam/desabilitam outros jobs

Não usar para só consultar horário atual ou para trabalho que cabe melhor em heartbeat.

## Fluxo mínimo
1. **Listar primeiro**
   - `openclaw cron list --json`
   - localizar nome/id existente antes de criar outro
2. **Escolher o tipo certo**
   - one-shot: `--at`
   - recorrente por calendário: `--cron`
   - recorrente por intervalo: `--every`
3. **Fixar delivery explícito**
   - para Telegram: `--announce --channel telegram --to <chatId>`
   - não confiar em `last` quando a entrega importa
4. **Fixar sessão**
   - normalmente: `--session isolated`
   - usar `--session-key` quando precisa voltar para um chat específico
5. **Escrever o prompt do cron com comportamento claro**
   - dizer quando responder `NO_REPLY`
   - dizer quando avisar
   - dizer qual tool preferir (`web_fetch` antes de `browser`, por exemplo)
   - se um cron mexe em outro, mandar usar o id exato do outro cron
6. **Verificar no final**
   - `openclaw cron show <id>`
   - conferir: horário, enabled, delivery, payload, delete-after-run
   - para one-shot, aceitar que o `show` pode exibir o horário convertido em UTC em vez do `tz` original

## Regras práticas
- One-shot com horário local sem offset: usar `--at 'YYYY-MM-DDTHH:MM:SS' --tz 'America/Sao_Paulo'`
- One-shot costuma aparecer em UTC no `show`; isso é normal. Verifica a conversão, não a presença do `tz`.
- Reminder pontual geralmente deve usar `--delete-after-run`.
- Se o cron da manhã precisa cancelar o da noite, cria os dois e depois edita o da manhã com o **id real** do da noite.
- Se o job deve ficar quieto, escreve literalmente: `responda exatamente NO_REPLY`.
- Se já existe job com o mesmo nome, prefere `edit` ou remove conscientemente antes de recriar.
- `openclaw cron edit` não é igual ao `add`; confirma flags com `--help` se houver dúvida.

## Padrão para cenário com dependência entre crons
1. criar cron A
2. criar cron B
3. pegar ids
4. editar A para referenciar o id de B
5. verificar A e B com `cron show <id>`

## Erros comuns
- esquecer `--channel` e `--to`
- confiar que `--tz` vai aparecer salvo em one-shot
- criar duplicata porque não listou antes
- prompt ambíguo sobre quando falar
- usar nome do cron em vez de id quando a ação pede id
- não verificar depois da criação

## Exemplo mental rápido
Se o pedido for “08h avisa se disponível; 18h avisa só se seguir indisponível; 08h cancela 18h se achar vaga”, o caminho seguro é:
- criar os dois one-shot com delivery explícito
- deixar o das 18h pronto primeiro ou editar o das 08h depois
- no prompt das 08h, mandar desabilitar o cron das 18h pelo id exato
- conferir ambos com `openclaw cron show`
