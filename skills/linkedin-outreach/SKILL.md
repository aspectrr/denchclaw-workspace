# LinkedIn Outreach - ELK Engineer & VP Pipelines

This skill handles LinkedIn outreach for two distinct audiences: ELK engineers (peer-to-peer learning) and VPs/Team Leads (business discovery). Both use a conversation flow approach — not scripts.

---

## Engineer Pipeline (Peer-to-Peer Learning)

**Tone:** Casual, conversational, one engineer talking to another. No sales pitch.

### Pipeline Stages

- **Not Connected** - We haven't connected yet
- **Connected** - They accepted our connection request
- **Opener** - We sent the opener message
- **Rapport** - Building rapport and digging into pain
- **Bridge** - We bridged to the product (if appropriate)
- **Ask** - We made an ask (call, demo, etc.)
- **Follow-up** - We're in follow-up mode

---

### Stage 1: The Opener

**Goal:** Get them talking about their work, understand their time allocation.

**When to update pipeline stage:** Set to `Opener` when you send the opener message.

```
Hi {name}, nice connecting with you. I'm an ELK engineer at OmniSock SOC and noticed you were a {job title}. Was wondering how much of your time each week is debugging pipeline issues vs building new things?
```

**What you're looking for:** Any indication they spend meaningful time on ELK debugging. The exact ratio doesn't matter — just get them talking.

**If they ask "why do you ask?":**

```
Ha fair question! I've been thinking a lot about how much time engineers like us lose to debugging vs actually building. For me it's mostly investigating broken pipelines, DLQs, Kafka lag, and building new integrations. What does debugging usually look like for you?
```

**If they say they don't do much debugging:** Probe whether they still work with ELK. If they don't touch it at all, qualify out early.

---

### Stage 2: Build Rapport + Dig Into Pain

**Goal:** Understand their specific ELK pain points and manual work.

**When to update pipeline stage:** Set to `Rapport` after they respond to the opener and you send the rapport-building message.

```
Yeah same for me, {brief relatable comment}. What does debugging usually entail for you? Is it mostly manual — like digging through Kibana, checking Logstash configs, investigating shard issues — or do you have tooling that helps?
```

**Adapt your relatable comment to what they said:**

- If they said mostly debugging: "Yeah same, I feel like I barely get to new projects some weeks."
- If they said 50/50: "Yeah that's pretty similar to me, it always depends on the week and what's on fire."
- If they said mostly project work: "Nice, I wish I could say the same — I end up debugging more than I'd like."

**What you're listening for:**

- "Mostly manual" / "digging through Kibana" / "checking configs" → perfect, this is your buyer
- "We use some automation but a lot is still manual" → great, there's a gap
- "We have a full observability stack" → might be harder sell, but still worth exploring
- Mentions of AI tools (Claude Code, Copilot, etc.) → great segue into what's missing

**If they mention AI tools:**

```
Oh interesting, how do you handle the ELK-specific side of that? I've found that general AI tools don't really understand ELK pipelines, Kafka, Logstash configs, or the distributed nature of the stack. Do you run into that?
```

This naturally leads to learning what's missing from their current tools.

---

### Stage 3: The Bridge (If Appropriate)

**Note:** For engineers, you might NOT bridge to a product pitch. The goal is learning first. Only bridge if:
- They've expressed strong pain
- They're actively asking what you're working on
- The conversation has gone 3-4 messages deep

**When to update pipeline stage:** Set to `Bridge` only if you bridge to the product pitch.

**If bridging:**

```
Yeah that's the most tedious part for me too. That's actually why I'm building an AI ELK engineer — it's like having a junior engineer who understands ELK, Kafka, Logstash, and can debug pipeline issues autonomously. It integrates with Slack/GitHub and learns from your team's incidents over time.
```

**If they mentioned AI tools and their limitations:**

```
So that's exactly what I'm building — an AI agent that actually understands the ELK stack (not just general code). It can debug pipelines, investigate Kafka lag, build Logstash configs from examples, and integrate with your existing workflows. Basically like having an ELK engineer on-call 24/7.
```

---

### Stage 4: The Ask (Learning First)

**Goal:** Continue the conversation, learn more, not pitch yet.

**When to update pipeline stage:** Set to `Ask` when you make a concrete ask (call, feedback on prototypes, etc.).

```
I'd love to hear more about how your team handles {specific thing they mentioned}. Do you have a dedicated ELK person or is it shared responsibility? What's the on-call rotation like?
```

**Or if they seem very engaged and curious:**

```
We're still in the early stages — mostly learning from engineers like you about what would actually help. Would you be open to a quick 15-min chat sometime to share more about your day-to-day with ELK? No pitch, just want to understand the pain better.
```

**Escalation ladder for engineers:**
1. Continue conversation (no ask)
2. Quick 15-min learning call (low commitment)
3. Feedback on early prototypes (if they're very engaged)

---

### Stage 5: Follow-Up (If They Go Silent)

**When to update pipeline stage:** Set to `Follow-up` after 3–5 days of no response and you send a follow-up message.

**Wait 3–5 days, then follow up with value:**

```
Hey {name}, no worries if you've been busy. I was actually thinking about what you said regarding {their specific situation} — it reminded me of a conversation I had with another ELK engineer who was dealing with {similar thing}. Been super common in the r/elasticsearch threads I've been reading. Any thoughts on that?
```

**Key principles:**
- Lead with something relevant to their situation
- Reference their specific pain/setup
- Keep it casual, not a "check in"
- Don't pitch unless the conversation naturally goes there

---

## VP / Team Lead Pipeline (Business Discovery)

**Tone:** Professional, respectful, curious. Not sales-y.

### Pipeline Stages

- **Not Connected** - We haven't connected yet
- **Connected** - They accepted our connection request
- **Opener** - We sent the thank you/opener message
- **Team Structure** - Discussing team structure and pain
- **AI/On-Prem** - Discussing AI usage and on-prem
- **Discovery Call** - Discovery call scheduled/completed
- **Pilot** - Pilot/LOI offered

---

### Stage 1: The Opener

**Goal:** Thank them for connecting, establish credibility, ask one simple question.

**When to update pipeline stage:** Set to `Opener` when you send the thank you/opener message.

```
Hi {name}, thanks for connecting. I'm an ELK engineer building an AI tool for ELK teams and noticed you're the {title} at {company}. Was curious — how does your team currently manage ELK? Do you have dedicated engineers or is it shared responsibility?
```

**What you're looking for:** Information about team structure and ELK's criticality to their business.

---

### Stage 2: Team Structure + Pain Points

**Goal:** Understand team constraints and pain.

**When to update pipeline stage:** Set to `Team Structure` after they respond to the opener and you send the team structure question.

```
Got it. And how big is the team that manages ELK? I've been talking to a lot of VPs who are understaffed and can't hire fast enough — the team is underwater with debugging and incident response while trying to build new things. Does that sound familiar at all?
```

**What you're listening for:**
- Team size (2-10 engineers is ideal)
- Whether ELK is mission-critical or just one tool among many
- Headcount constraints / hiring challenges
- Specific pain points (on-call load, debugging time, etc.)

---

### Stage 3: AI Usage + On-Prem

**Goal:** Qualify on AI experience and deployment model.

**When to update pipeline stage:** Set to `AI/On-Prem` after they respond to team structure questions and you send the AI/on-prem questions.

```
Understood. And have you tried any AI tools for the ELK work — Claude Code, Copilot, anything like that? I've found that most tools don't work well for ELK because they lack: safe Ansible execution, on-prem access, Slack/GitHub integration, and persistent context. Just curious if you've run into that.
```

**Follow-up:**

```
And are you running ELK on-prem or in Elastic Cloud? On-prem is where the biggest gap is — most AI tools assume cloud-only.
```

---

### Stage 4: The Discovery Call Ask

**Goal:** Get them on a 30-min call with Collin to learn more.

**When to update pipeline stage:** Set to `Discovery Call` when the call is scheduled or completed.

**Only ask if:**
- They've expressed pain (understaffed, drowning in debugging)
- ELK is mission-critical for them
- They're interested in AI solutions
- They run on-prem (ideal) or are open to it

```
Thanks for sharing all that — super helpful context. This sounds exactly like the kind of team I'm building this for.

I'd love to learn more about your situation — team size, current stack, biggest pain points. Would you be open to a quick 30-min call sometime next week? No pitch, just want to understand if this could actually help your team.

I'm flexible on time — what works for you?
```

---

### Stage 5: Pilot / LOI (Post-Call)

**When to update pipeline stage:** Set to `Pilot` after Collin offers a pilot/LOI on the discovery call.

**This is handled by Collin after the discovery call.** The AI agent should:
- Document call notes in the CRM
- Update VP prospect status
- Flag if they seem like a good pilot candidate

**Pilot language (for Collin to use on the call):**

```
Based on what you've shared, it sounds like your team could really use some AI leverage. I'm building this as an open source project with a paid tier — the idea is an "AI ELK Engineer" that operates like a full-time employee, integrated with your Slack, GitHub, and ELK stack.

If you're interested, I'd love to run a pilot with your team — no cost, just want real feedback from engineers who are actually dealing with this. We can do it as a letter of intent if you need to formalize it.

What do you think?
```

---

### VP Follow-Up (If They Go Silent)

**Wait 5–7 days (VPs are busier), then:**

```
Hey {name}, no worries if you've been busy — I know how it goes. Just wanted to circle back on the ELK tool I'm building.

I've been talking to a lot of {their company size / industry} companies who are in the same boat — understaffed ELK teams drowning in debugging while trying to ship features. I'm basically building an "AI ELK Engineer" that can handle 30-50% of that work.

If you're still interested, I'd love to learn more about your setup. Happy to keep it to 15-20 minutes if that's easier. Let me know if you're open to it.

Otherwise, no pressure — totally understand if the timing isn't right.
```

---

## Pipeline Stage Updates

### When to Update Pipeline Stage

**Always update the pipeline stage after every significant interaction:**

**Engineers:**
- `Not Connected` → Before sending connection request
- `Connected` → When they accept the connection request
- `Opener` → When you send the opener message
- `Rapport` → After they respond and you send rapport-building message
- `Bridge` → Only if you bridge to the product pitch
- `Ask` → When you make a concrete ask (call, feedback, etc.)
- `Follow-up` → After 3–5 days of no response and you send follow-up

**VPs:**
- `Not Connected` → Before sending connection request
- `Connected` → When they accept the connection request
- `Opener` → When you send the thank you/opener message
- `Team Structure` → After they respond and you send team structure questions
- `AI/On-Prem` → After they respond and you send AI/on-prem questions
- `Discovery Call` → When the call is scheduled or completed
- `Pilot` → After Collin offers a pilot/LOI

### Escalation Logic

**When to Ask Collin for Input:**

**Engineer pipeline:**
- They express strong interest or ask for a demo
- The conversation goes somewhere unexpected
- You're unsure how to respond

**VP pipeline:**
- They agree to a discovery call → Collin needs to schedule
- They express objections or skepticism
- They mention budget constraints or approval processes
- You're unsure if they qualify

**What to Send Collin:**

Format: concise context + draft if applicable

```
Eng: {name} at {company}, {role}
Context: {brief summary of conversation so far}
Latest message: {their last message}
My draft response: {what you're thinking of saying}
Action needed: {approval / feedback / scheduling / etc.}
```

Send via sessions_send to main session.

---

## CRM Updates

### Engineer Conversations

After each meaningful exchange, update the `engineering` CRM object:

- **Pipeline Stage:** Update based on the stage you're in (Not Connected → Connected → Opener → Rapport → Bridge → Ask → Follow-up)
- **Pain Points:** Add any specific pain they mentioned
- **ELK Stack:** Versions, deployment model (on-prem/cloud), tooling
- **AI Usage:** What they've tried, what's missing
- **Notes:** Any other relevant context

### VP Conversations

After each message exchange, update the `vp_prospect` CRM object:

- **Pipeline Stage:** Update based on the stage you're in (Not Connected → Connected → Opener → Team Structure → AI/On-Prem → Discovery Call → Pilot)
- **Team Size:** Number of engineers managing ELK
- **ELK Criticality:** Mission-critical / Important / One of many tools
- **Pain Points:** Specific pain they mentioned
- **AI Experience:** What they've tried, limitations
- **Deployment:** On-prem / Cloud / Hybrid
- **Notes:** Any other relevant context

---

## Qualifying Out

### Engineers

Move on if:
- They don't work with ELK at all
- They're purely sales/marketing/PM (not technical)
- Their ELK work is fully automated and they're happy with it
- They show zero engagement after 2–3 messages
- They're job seekers / contractors (no long-term influence)

### VPs

Move on if:
- Their company is too large (500+ employees where ELK is one of many tools)
- ELK is not mission-critical to their business
- They have no interest in AI solutions
- They've fully outsourced ELK to a managed service
- They're not decision-makers (can't approve budget or headcount)

---

## Quick Reference: What NOT To Do

| Instead of this... | Do this... |
|---------------------|------------|
| Pitching the product in message #2 (eng) | Ask 2–3 questions about their workflow first |
| "Let me know if you have questions!" | Ask a specific, relevant question |
| "Had a chance to think about it?" | Reference their specific pain and add value |
| Same message to everyone | Adapt to what they actually told you |
| Scheduling a call too early (eng) | Continue conversation, let it develop naturally |
| Ending with a statement | End with a question or clear next step |
| Pushing for a pilot on first contact | Learn first, sell later |
| Ignoring their company size | Qualify — small/medium companies where ELK is mission-critical |

---

## Escalation Ladders

### Engineers (Low-Commitment to High)

1. **Continue conversation** (no ask)
2. **Quick 15-min learning call** (if they're curious)
3. **Feedback on prototypes** (if they're very engaged)

### VPs (Low-Commitment to High)

1. **Continue conversation** (no ask)
2. **30-min discovery call** (with Collin)
3. **Pilot / LOI** (if they're a strong fit)

---

## Principles Summary

1. **Learn before you sell** — Understand their pain first
2. **Ask, don't tell** — Use questions to guide the conversation
3. **Reference what they said** — Don't sound like a template
4. **Qualify out early** — Don't waste time on bad fits
5. **Low-friction asks** — Make it easy for them to say yes
6. **Escalate gradually** — Don't jump to the big ask too fast
7. **Be human** — Casual for engineers, professional for VPs
8. **Know your audience** — Different pipelines for different personas
9. **Update pipeline stages** — Always track where each person is in the process
