# 04 — Skills

Este repositório pode carregar skills reutilizáveis sem copiar contexto privado.

## Skills incluídas

- `replica-assistant` — comportamento base para um agente recém-configurado.
- `cerebro` — conecta um segundo cérebro em Markdown já configurado e gera briefing operacional.

## Instalar a skill `cerebro` em outro agente

Copie a pasta:

```bash
skills/cerebro
```

para a pasta de skills do workspace/agente de destino, por exemplo:

```bash
~/.openclaw/workspaces/<workspace>/.agents/skills/cerebro
```

Depois configure o caminho do segundo cérebro no ambiente/agente de destino. A skill não inclui contexto, memórias pessoais, pendências reais nem arquivos do segundo cérebro; ela só define o modo de leitura e síntese.
