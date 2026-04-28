---
name: cerebro
description: Usa um segundo cérebro em arquivos Markdown para continuidade entre sessões de agentes de IA. Use quando for preciso conectar o contexto persistente de trabalho, gerar um briefing do estado atual, consultar pendências, deadlines, decisões, equipe e projetos, ou operar comandos como "cerebro", "/cerebro", "liga o cérebro" e "conecta o segundo cérebro".
---

# cerebro

Usar esta skill para operar um segundo cérebro já configurado e transformar os arquivos de memória em contexto acionável para a sessão atual.

Esta skill não é responsável por setup inicial, instalação, cópia de templates, configuração de ambiente, hooks ou GitHub. Tratar isso como etapa externa ao uso da skill.

## Objetivo

Ler o segundo cérebro configurado, sintetizar o estado atual e permitir consultas pontuais sem obrigar o usuário a navegar manualmente pelos arquivos.

## Pré-condição

Assumir que o segundo cérebro já existe e que `SECOND_BRAIN_PATH` ou um caminho equivalente já foi definido pela camada de configuração do ambiente.

Se o caminho não estiver disponível, informar de forma curta que o sistema não está conectado e pedir o caminho do segundo cérebro, sem transformar isso em um fluxo de instalação.

## Fluxo principal

### 1. Ler contexto em paralelo

Tentar ler, sem falhar a operação toda se algum item estiver ausente:

1. `memory/context/pendencias.md`
2. `memory/context/deadlines.md`
3. o arquivo do mês atual em `memory/context/decisoes/`
4. `memory/context/business-context.md`
5. `memory/context/people.md`
6. `memory/projects/_index.md`
7. sessões recentes em `memory/sessions/`
8. `skills/_registry.md`, se existir

Não despejar o conteúdo bruto para o usuário. Usar isso para sintetizar o briefing.

### 2. Fazer checagem de integridade

Procurar sinais de desalinhamento, por exemplo:

- houve commits recentes, mas não há log de sessão do dia;
- decisões foram atualizadas mais recentemente do que o contexto consolidado;
- arquivos centrais de contexto estão muito antigos;
- existe conflito de merge no repositório.

Se houver conflito de merge, mencionar antes do briefing.

### 3. Entregar briefing compacto

Responder em formato curto e acionável:

```text
=== SEGUNDO CÉREBRO — Conectado DD/MM/YYYY ===

ESTADO:
- N pendências
- N deadlines próximos
- N projetos ativos
- N skills disponíveis

ÚLTIMOS DIAS:
- resumo consolidado das sessões recentes

DECISÕES RECENTES:
- decisão 1
- decisão 2

ALERTAS:
- alertas relevantes
```

Encerrar com uma pergunta operacional simples, por exemplo: `O que vamos trabalhar?`

### 4. Suportar pull on demand

Após o briefing, permitir pedidos específicos sem reexplicar o modo:

- `mostra pendências`
- `mostra deadlines`
- `mostra decisões`
- `mostra projetos`
- `mostra equipe`
- `mostra <nome do projeto>`

Quando os dados já tiverem sido carregados, reutilizar o contexto coletado e evitar trabalho repetido.

## Consultas que devem disparar esta skill

- `/cerebro`
- `cerebro`
- `liga o cérebro`
- `conecta o segundo cérebro`
- `mostra pendências`
- `mostra deadlines`
- `mostra decisões`
- `mostra projetos`
- `mostra equipe`
- `mostra <projeto>`
- pedidos para retomar o contexto de sessões anteriores
- pedidos para resumir a memória persistente antes de começar um trabalho

## Relação com outros agentes de IA

Tratar o segundo cérebro como fonte canônica de contexto compartilhado entre agentes.

- Ler antes de iniciar trabalho relevante.
- Escrever atualizações por meio do fluxo de salvamento definido fora desta skill.
- Priorizar consistência de nomes de projetos, pessoas, decisões e pendências.
- Evitar criar memória paralela fora do segundo cérebro quando a informação precisa persistir.

## Regras de comportamento

- Ser direto e sem preâmbulo longo.
- Tratar arquivos ausentes como situação normal.
- Preferir síntese a despejar arquivos inteiros.
- Preservar o idioma do usuário ao apresentar o briefing.
- Se nada puder ser carregado, informar claramente que o segundo cérebro não pôde ser lido e apontar para `SECOND_BRAIN_PATH`.
