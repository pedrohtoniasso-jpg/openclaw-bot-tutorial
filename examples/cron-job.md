# Exemplo de cron OpenClaw

```bash
openclaw cron add \
  --name "daily-memory-review" \
  --cron "0 8 * * *" \
  --tz "America/Sao_Paulo" \
  --session isolated \
  --message "Revise arquivos recentes em memory/ e atualize MEMORY.md com aprendizados importantes."
```
