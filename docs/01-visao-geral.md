# 01 — Visão geral

A Claw funciona por uma combinação de:

1. **OpenClaw Gateway** — recebe mensagens, expõe tools e coordena canais.
2. **Workspace** — pasta com `AGENTS.md`, `SOUL.md`, `USER.md`, skills e memória.
3. **Tools** — `exec`, `read`, `write`, `browser`, `cron`, `gateway`, `message`, `tts`, etc.
4. **Skills** — instruções reutilizáveis para fluxos específicos.
5. **Memória** — arquivos locais que acumulam contexto ao longo do tempo.

Este tutorial replica a arquitetura, mas começa com memória limpa.
