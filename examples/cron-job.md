# Exemplos de cron OpenClaw

Veja `docs/05-crons.md` para os crons completos usados no agente estilo Claw.

Exemplo mínimo:

```bash
openclaw cron add \
  --name "daily-memory-review" \
  --cron "0 8 * * *" \
  --tz "America/Sao_Paulo" \
  --session isolated \
  --message "Revise arquivos recentes em memory/ e atualize MEMORY.md com aprendizados importantes." \
  --announce --channel telegram --to "TELEGRAM_CHAT_ID"
```
