---
name: whatsapp-context-ingestion
description: Use when WhatsApp conversations should be treated as a passive source of context, reminders, promises, purchases, follow-ups, or dates, including proactive review of chats without replying in WhatsApp.
---

# whatsapp-context-ingestion

## Overview

Use WhatsApp as a passive source of context, never as an action channel. Extract useful context, infer missing outbound replies when only received messages are visible, detect commitment signals, and capture the resulting operational actions outside WhatsApp.

## When to Use

Use this skill when:
- reviewing WhatsApp conversations for context, promises, reminders, purchases, follow-ups, or dates
- turning WhatsApp messages into operational memory for the user
- working proactively through chats where there is a real chance of useful context or upcoming action

Do not use this skill when:
- the source is not WhatsApp
- the task is to define memory structure, files, or persistence format
- the task is to reply to someone or act socially in the user's name

## Fixed Rules

- Never reply in WhatsApp.
- Never message third parties.
- Never act socially on the user's behalf inside WhatsApp.
- Telegram is the operational capture channel.
- `cerebro` is responsible for structured persistence and second-brain organization.
- Reading access does not imply permission to act in the channel.

## Operational Flow

1. Read the conversation as context, not as a response surface.
2. Identify who is involved, what relationship matters, and what topic is in progress.
3. Assume WhatsApp context may be one-sided: the user's sent replies may be missing.
4. Extract promises, purchases, follow-ups, deadlines, reminders, and next steps.
5. Infer the user's likely missing reply from the other person's follow-up when possible.
6. Classify the detected signal as strong, inferred-positive, declined, or ambiguous.
7. If the signal is strong or inferred-positive, capture the derived reminder, task, event, or follow-up outside WhatsApp.
8. If there is ambiguity around a concrete future obligation, treat ambiguity as positive and capture a tentative item instead of dropping it.
9. Send the operational capture to the authorized channel when the user should be reminded or the item should stay visible.
10. If the information belongs in the second brain, hand off persistence to `cerebro` instead of inventing parallel structure.

## Strong Signal

Treat these as strong signals and capture them automatically:
- explicit reminder phrases such as “me lembra disso”
- purchase intent such as “preciso comprar”
- clear scheduling intent such as “vamos marcar”
- explicit commitments such as “te mando depois” when tied to a real obligation
- dates, times, deadlines, or concrete future obligations
- counterpart follow-ups that confirm an earlier proposal, such as “fechou então”, “combinado”, “beleza então”, or “show, te vejo lá”

## Missing Outbound Replies

When the user's sent messages are missing, infer the likely missing reply from the next received message:

- Proposal + “fechou então” / “combinado” / “beleza então” → infer the user accepted; capture the event/reminder.
- Proposal + “ah, de boa” / “sem problemas” / “outra hora então” → infer the user declined or postponed; do not schedule the original event.
- Proposal with a concrete time/date but no clear acceptance or rejection → treat ambiguity as positive; capture a tentative reminder/event.
- If the inferred item may be wrong but missing it would be worse, capture it with tentative wording instead of staying silent.

Examples:

```text
Pessoa: Vamos no mercado hoje 19h?
Pessoa: Fechou então
=> Capture: mercado hoje às 19h. Confidence: inferred-positive.

Pessoa: Vamos no mercado hoje 19h?
Pessoa: Ah, de boa. Marcamos outra hora então
=> No event for 19h. Optional context-only follow-up: remarcarmos mercado, sem horário definido.
```

## Weak or Ambiguous Signal

If the signal is vague, incomplete, or socially speculative:
- for concrete future obligations, capture a tentative item because ambiguity is currently treated as positive
- for vague context without time, date, obligation, purchase intent, or follow-up, keep it as context
- prefer lightweight wording over assertive certainty when the item is inferred

## Telegram Integration

Use Telegram as the operational destination for captured items such as:
- reminders the user should see
- short tasks
- follow-up notes
- event-like commitments worth surfacing
- compact operational summaries when several related items appear together

Keep the output brief and action-oriented.

## `cerebro` Integration

This skill must not define schemas, folder structure, filenames, or long-term memory rules.

When context should become structured memory, persistent context, or second-brain organization:
- invoke `cerebro`
- let `cerebro` decide where and how the information is stored
- avoid parallel memory systems

## Good Uses

- Reviewing a WhatsApp thread and extracting promises, purchases, reminders, and deadlines.
- Proactively spotting a clear commitment and capturing it in Telegram.
- Passing durable context to `cerebro` when the information belongs in the second brain.

## Bad Uses

- Replying to someone in WhatsApp.
- Treating vague commentary as a confirmed task.
- Creating a separate memory structure outside `cerebro`.
- Assuming read-only access means permission to participate in the chat.

## Common Mistakes

- Confusing observation with permission to act.
- Turning every potentially relevant message into a task.
- Skipping the strong-vs-ambiguous decision.
- Persisting structured memory without going through `cerebro`.
- Forgetting that the authorized channel is the operational channel and WhatsApp is only the source.

## Recommended Output Shape

Prefer short captures in this shape:

```text
Context: <what matters>
Action captured: <reminder/task/follow-up/event>
Destination: Telegram | cerebro
Confidence: strong | inferred-positive | declined | ambiguous
```

If confidence is inferred-positive or ambiguous, keep the action lightweight/tentative rather than overstating certainty.
