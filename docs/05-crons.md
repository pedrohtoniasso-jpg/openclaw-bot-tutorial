# 05 — Crons principais

Estes são os crons principais para um agente OpenClaw estilo Claw. Troque `TELEGRAM_CHAT_ID` pelo chat autorizado do usuário.

```bash
export TELEGRAM_CHAT_ID="COLOQUE_O_CHAT_ID_AQUI"
```

## Backup e update diário

Requer um script de backup/update, por exemplo `/home/opc/scripts/openclaw-daily-backup-update.sh`.

```bash
cat > /tmp/openclaw-backup-update-prompt.txt <<'PROMPT'
Execute o script diário consolidado: /home/opc/scripts/openclaw-daily-backup-update.sh

Objetivo do script:
- criar backup local verificado em /home/opc/backups/openclaw
- enviar o backup para Google Drive na pasta OpenClaw Backups quando gog estiver disponível
- manter retenção de 14 dias local e no Drive
- checar updates e atualizar automaticamente se houver update disponível
- executar openclaw health ao final da rotina
- responder resumo curto com backup local, backup Drive, update disponível, update executado, health check, versão final e erros relevantes

Regras:
- só faça update automático se o usuário tiver aprovado isso explicitamente
- não mexer em firewall, SSH ou outras configs críticas do host
- se backup local falhar, não prossiga para Drive/update
- se upload Drive falhar, reporte claramente mas não apague backup local
- não inventar sucesso
PROMPT

openclaw cron add \
  --name "openclaw-auto-backup-update" \
  --description "Backup diário do OpenClaw e update automático quando houver versão nova" \
  --cron "0 2 * * *" \
  --tz "America/Sao_Paulo" \
  --session isolated \
  --message "$(cat /tmp/openclaw-backup-update-prompt.txt)" \
  --timeout-seconds 2400 \
  --tools exec,process,read,write,edit \
  --announce --channel telegram --to "$TELEGRAM_CHAT_ID"
```

## Daily check / revisão de atividades

```bash
cat > /tmp/daily-check-prompt.txt <<'PROMPT'
Nome conceitual desta rotina: daily check.

Você é o operador diário do usuário. Sua meta não é gerar relatório genérico; é reduzir pendências reais, evoluir o agente hoje e resolver sozinho o que couber com segurança.

Aprovação permanente desta rotina:
- Pode executar ações de baixo e médio risco dentro do OpenClaw, workspace e segundo cérebro sem pedir confirmação extra, desde que sejam reversíveis, verificáveis e proporcionais ao benefício.
- Pode criar, editar, desabilitar e reorganizar crons; ajustar skills, prompts, scripts, docs e arquivos do workspace; resolver pendências operacionais; concluir tarefas pendentes que não exponham dados nem afetem terceiros.
- Antes de instalar algo, autenticar serviço novo, confiar em fonte externa nova, baixar artefato, executar comando copiado da internet, ou enviar dados para fora do ambiente, use obrigatoriamente a skill safety-check.
- Se o safety-check der CAUTION ou BLOCK, não execute a ação; reporte apenas a alternativa segura.

Nunca fazer sem aprovação explícita:
- mexer em firewall, SSH, pairing, segredos/tokens, roteamento principal de modelos, exclusões destrutivas, ou configuração crítica sem backup, validação e motivo muito forte.
- enviar mensagens para terceiros, criar eventos externos, ou vazar dados privados.

Fluxo obrigatório:
1. Revisar sessões, memória recente e histórico do dia anterior para localizar pendências interrompidas, follow-ups esquecidos, promessas não concluídas, erros e tarefas com próxima ação óbvia.
2. Revisar e sincronizar o segundo cérebro, se existir.
3. Revisar agenda das próximas 24-72h quando Calendar/Gog estiver disponível.
4. Responder internamente e agir sobre estas perguntas:
   - O que vou alterar para ser hoje um agente melhor do que ontem?
   - Quais atividades meu usuário tem pendentes que eu consigo resolver sozinho hoje?
5. Executar primeiro as ações low/medium risk de maior impacto.
6. Se mexer em cron, skill, script, prompt ou config, validar depois.
7. Se nada seguro puder ser executado, reportar só o que sobrou e a próxima ação mais útil.

Formato de saída:
- Se não houver ação executada, pendência relevante, risco ou mudança real: responder exatamente NO_REPLY.
- Caso contrário, enviar no máximo 5 bullets.
- Cada bullet deve conter ação executada ou achado + próxima ação quando necessário.
- Sem tabela, sem introdução, sem textão.
PROMPT

openclaw cron add \
  --name "daily-check" \
  --description "Daily check operacional com autonomia útil, safety gate e melhoria contínua do agente" \
  --cron "0 6 * * *" \
  --tz "America/Sao_Paulo" \
  --session isolated \
  --message "$(cat /tmp/daily-check-prompt.txt)" \
  --thinking medium \
  --timeout-seconds 1500 \
  --tools exec,process,read,write,edit,cron,web_fetch \
  --announce --channel telegram --to "$TELEGRAM_CHAT_ID"
```

## Radar semanal Moltbook

```bash
cat > /tmp/weekly-moltbook-radar-prompt.txt <<'PROMPT'
Use a skill moltbook para revisar a última semana no Moltbook e buscar novidades sobre agentes, OpenClaw, IA, automações e casos reais de uso feitos por outras pessoas.

Objetivo:
1. Revisar novidades da última semana.
2. Identificar ideias úteis para meu ambiente.
3. Buscar novas skills, APIs, integrações e workflows.
4. Aprender com o que outros usuários/agentes estão fazendo.
5. Transformar isso em sugestões práticas.

Saída:
# Radar Semanal IA/OpenClaw

## Novidades relevantes
- ...

## Ideias aplicáveis
- ...

## Skills/API para testar
- ...

## Melhor ação da semana
- ...

## Prioridade
Baixa / Média / Alta

Regras:
- ser objetivo
- priorizar aplicações reais
- evitar hype e notícias inúteis
- não executar nada sem aprovação
- se o Moltbook ainda não estiver configurado, dizer isso claramente e não inventar resultado
PROMPT

openclaw cron add \
  --name "weekly-moltbook-radar" \
  --description "Radar semanal Moltbook sobre IA, agentes e OpenClaw" \
  --cron "30 6 * * 1" \
  --tz "America/Sao_Paulo" \
  --session isolated \
  --message "$(cat /tmp/weekly-moltbook-radar-prompt.txt)" \
  --announce --channel telegram --to "$TELEGRAM_CHAT_ID"
```

## Otimização semanal do OpenClaw

```bash
cat > /tmp/weekly-openclaw-optimization-prompt.txt <<'PROMPT'
Nome conceitual desta rotina: weekly openclaw optimization.

Objetivo: revisar a última semana e melhorar o OpenClaw de forma prática. Prefira pequenas otimizações reais a relatórios abstratos.

Aprovação permanente desta rotina:
- Pode executar melhorias de baixo e médio risco dentro do OpenClaw, workspace e segundo cérebro quando forem reversíveis, verificáveis e de benefício claro.
- Pode criar, editar, desabilitar ou limpar crons; melhorar skills, prompts, scripts, docs e fluxos operacionais; ajustar configuração não crítica; reduzir ruído, retrabalho e fragilidade.
- Antes de instalação, autenticação, integração nova, download, comando externo copiado ou envio de dados para fora, usar obrigatoriamente a skill safety-check.
- Se o safety-check der CAUTION ou BLOCK, não executar a ação; apenas sugerir a alternativa segura.

Nunca fazer sem aprovação explícita:
- mexer em firewall, SSH, pairing, segredos/tokens, roteamento principal de modelos, exclusões destrutivas ou mudanças críticas difíceis de reverter.

Fluxo obrigatório:
1. Revisar os últimos 7 dias de sessões, memória, cron runs, erros, falhas de delivery, padrões repetitivos e fricções operacionais.
2. Identificar 1 a 3 otimizações valiosas.
3. Classificar cada otimização como LOW, MEDIUM ou HIGH.
4. Aplicar nesta execução as otimizações LOW e MEDIUM mais valiosas, até no máximo 2 mudanças reais por run.
5. Validar cada mudança com evidência adequada: openclaw health, cron show/list, skill existente, git status, diff ou artefato equivalente.
6. Para qualquer item HIGH ou dependente de decisão humana, não executar; apenas sugerir aprovação.

Formato de saída:
- Se não houver mudança nem sugestão útil: responder exatamente NO_REPLY.
- Caso contrário, no máximo 5 bullets.
- Prefixar com `APLICADO:` quando a melhoria já tiver sido executada.
- Prefixar com `APROVAR:` quando a melhoria precisar de decisão humana.
- Sem tabela, sem introdução, sem relatório longo.
PROMPT

openclaw cron add \
  --name "weekly-openclaw-optimization" \
  --description "Revisão semanal com otimizações práticas e autoaplicação de melhorias low/medium risk no OpenClaw" \
  --cron "15 7 * * 1" \
  --tz "America/Sao_Paulo" \
  --session isolated \
  --message "$(cat /tmp/weekly-openclaw-optimization-prompt.txt)" \
  --thinking medium \
  --timeout-seconds 1800 \
  --tools exec,process,read,write,edit,cron,web_fetch \
  --announce --channel telegram --to "$TELEGRAM_CHAT_ID"
```

## Saúde semanal dos crons

```bash
cat > /tmp/cron-health-report-prompt.txt <<'PROMPT'
Revise apenas os crons do OpenClaw usando o scheduler nativo. Consulte status, lista de jobs e histórico recente de execuções para montar um diagnóstico semanal.

Entregue exatamente neste formato:
✅ X Crons executando corretamente
❌ X Crons com falha

Crons com falha:
- nome do cron
- motivo da falha
- última execução
- sugestão objetiva de solução

Regras:
- ser objetivo
- só diagnosticar
- não corrigir nada automaticamente
- considerar apenas crons do OpenClaw
- se não houver falhas, dizer isso claramente
PROMPT

openclaw cron add \
  --name "cron-health-report" \
  --description "Relatório semanal de saúde dos crons do OpenClaw" \
  --cron "0 8 * * 1" \
  --tz "America/Sao_Paulo" \
  --session isolated \
  --message "$(cat /tmp/cron-health-report-prompt.txt)" \
  --announce --channel telegram --to "$TELEGRAM_CHAT_ID"
```

## Verificação

```bash
openclaw cron list
openclaw cron status
openclaw cron run ID_DO_CRON
```
