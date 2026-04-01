# Long-Term Memory

## User Profile

### Basic Info
- **Name:** (not yet captured)
- **Role:** ELK Stack Engineer (day job)
- **Side Project:** Building AI tool for ELK debugging/automation
- **Work Context:** SOC-as-a-service company using Elastic as SIEM
- **Availability:** Nights and weekends

### What They Care About
- Learning from peers about ELK pain points
- Building "Claude Code for ELK Engineers" - an augmentation tool
- Mission-critical ELK stack maintainers (not contractors, not job-seekers)
- Finding patterns through conversations, not sales pitches

### Target Persona (Refined 2026-04-01)
**ICP: VPs and Team Leads at SMALL-MEDIUM companies where ELK is mission-critical**

**Must Have:**
- VP of Platform/Infrastructure, Director of SRE, or Team Lead
- **Small-to-medium company** (50-500 employees ideal, or team of 2-10 engineers)
- **ELK is mission-critical** — the company runs on ELK, it's not just one of many tools
- Responsible for team productivity and incident response
- Managing understaffed team
- NOT job seeking, NOT open to work
- NOT at IT services/consulting companies

**Size Refinement (2026-04-01):**
- Large companies (Discord, Goldman Sachs, Stripe, BBVA, Wayfair) are NOT ideal ICP
- They have large platform teams, dedicated Elastic consulting, and DSE support
- Their ELK pain is one of many problems, not the core bottleneck
- We want: **small/medium company where 1-3 engineers manage ELK and it's absolutely critical**

**Why small-medium + mission-critical:**
- A 10-person DevOps team at a 200-person fintech where ELK goes down = business critical
- The VP/Director personally feels the pain every day
- Headcount budget exists but hiring is slow/expensive
- ELK is so central that "AI help" is a no-brainer

**NOT Good Fits:**
- Individual contributors without budget influence
- Contractors/C2C (temporary, no influence)
- Job seekers (leaving, can't advocate)
- IT services companies (they provide ELK support to clients)
- People at Elastic/Splunk (competitors)
- Large enterprises with big platform teams (Discord, Goldman, Stripe, BBVA, etc.)

**Strategic Pivot (2026-03-31):**
- Originally: Bottom-up, Claw Code style (developers adopt it)
- Now: Top-down, AI employee (VPs/team leads buy it for their teams)
- This is sold out of **headcount budget**, not tooling budget
- An "AI ELK Engineer" with Slack, email, GitHub integration — not a developer tool

### Current Project: AI-Native ELK Engineer
**Problem:** ELK engineers spend 70-80% of time debugging pipeline issues, dealing with DLQs, investigating Kafka lag, building new pipelines — while being on-call for critical systems.

**Solution:** AI agent that can:
- Debug pipelines automatically from on-call alerts
- Build logstash pipelines from examples
- Investigate distributed system issues (Kafka, Logstash, etc.)
- Work with Ansible for infrastructure

**Monetization:** Open source core + Paid SaaS/Enterprise

---

## Key Decisions & Learnings

### 2026-03-30: Validation Over Building
- Shifted from broad "AI for on-prem" to specific "ELK debugging assistant"
- Validated problem through Reddit research — people actively posting about ELK pain points
- Decided to sell manual service first ($500 fix / $2k/month) before building product
- Target persona: Solo ELK admins at small companies where ELK = critical business function

### Lead Research Process Established
1. Search r/elasticsearch, r/devops, r/sysadmin for pain points
2. Filter for posts 30-90 days old maximum
3. Add to CRM with full context (URL, description, posted date, priority)
4. Tag lead age: Fresh (<30d), Warm (30-90d), Cold (>90d)
5. Prioritize Fresh leads for outreach

---

## Active Workstreams

### 1. Learning Conversations (Primary)
- [ ] Have 10-20 peer conversations with ELK engineers
- [ ] Ask "what's your biggest time sink?" (not selling)
- [ ] Document patterns in conversation tracker object
- [ ] Track in /docs/first-10-conversations-plan.md

### 2. LinkedIn Outreach (Automated)
- ✅ Cron job set up: Daily at 2 PM ET (20-25 connections/day)
- ✅ ICP-filtered search terms
- ✅ Blank connection requests (no message)
- ✅ **Sidebar recommendations strategy** - Uses `get_sidebar_profiles` from high-quality connections to find similar prospects
- ✅ **Connection tracking fields added:**
  - **Connection Status:** Not Connected / Pending / Connected / Rejected
  - **Connection Quality:** Unrated / Great Fit / Good Fit / OK Fit / Bad Fit / Not ICP
  - **Feedback Notes:** Rich text for Collin to add notes

### 3. VP/Director Search Strategy (NEW - 2026-03-31)
- ✅ Separate strategy for decision-makers (VPs, Directors, Team Leads)
- ✅ Target: VP of Platform/Infrastructure, Director of SRE/Platform, Platform Team Lead
- ✅ Company size: 50-500 employees (small-medium)
- ✅ New CRM object: `vp_prospect` with Status pipeline
- ✅ Blank connection requests → Follow-up message after accepted
- ✅ Outbound messaging emphasizes "AI ELK Engineer for your understaffed team"
- [ ] Hand off to Collin for conversation follow-ups
- [ ] **Important:** Collin should update Connection Quality after conversations to improve ICP targeting

### 3. Lead Pipeline Status (2026-03-30)
**Total Leads:** 28 (18 from Reddit + 12 from LinkedIn)
**By ICP Fit:**
- **Fit - Ideal:** 0 (need more research)
- **Fit - Good:** 0 (need more research)
- **Maybe:** 4 (need company size verification)
- **Unknown:** 8 (Reddit leads - need follow-up)
- **Out - Job Seeker:** 2
- **Out - Competitor:** 3 (Elastic/Splunk)
- **Out - Consultant:** 1
- **Out - IT Services:** 2 (LTIMindtree, CGI)

---

## Market Research Summary (2026-03-31)

Full strategy doc: `/docs/elk-engineer-market-strategy.md`

### Key Insight: Headcount Validation
**"ELK Engineer" is already a job title** — companies pay $120–200K/year for humans to do this work. This is stronger validation than any survey:
- If companies pay$150K/year for a human, they'd pay $10–50K/year for AI that handles 30–50% of the work
- The "inferior solution" is humans (sleep, burn out, expensive, slow onboarding)
- AI agent is available24/7, onboards instantly, costs $20K/year
- **This isn't sold from tooling budget — it's sold from headcount budget**

### Market Sizing
| Layer | Size | Focus |
|-------|------|-------|
| TAM | $14.6–47.8B | AI DevOps/AIOps market |
| SAM | $2.85–6.5B | Observability platforms |
| SOM | $100–500M | Self-managed ELK teams |
| **Headcount Value** | **$2.25–7.5B/year** | 50K–100K instances × 1–2 FTEs × $150K |

### Whitespace
- 40–60% of ELK deployments are self-managed
- Elastic AI requires Enterprise tier + Cloud — excludes self-managed
- No AI tool unifies ELK + Kafka + Ansible knowledge
- Privacy-first positioning: Elastic sends data to third-party LLMs

### Top Pain Points (by frequency)
1. Shards stuck INITIALIZING/UNASSIGNED (50+ threads)
2. Cluster state timeouts / Master overload (30+ threads)
3. Split-brain / Discovery failures (25+ threads)
4. Docker/K8s deployment issues (20+ threads)
5. Version upgrade problems (15+ threads)

### Positioning Shift
- **Old:** "Debugger for ELK" (tool budget)
- **New:** "Virtual ELK Engineer" (headcount budget)
- **Value prop:** "Your next ELK engineer costs $150K. Or AI handles 50% of the work for $20K."

### Validation Status
✅ Green flags: Real pain, willingness to pay (headcount exists), 28 leads, scratching own itch
⚠️ Needed: 3–5 paid debugging sessions to confirm willingness to pay for AI specifically

### Day-Job Dogfooding Signal (2026-03-31)
**Critical Validation:** Collin's own ELK team is trying to use Codex/Copilot to automate ELK infrastructure and hitting walls:

**What they tried:**
- Codex/Copilot for ELK automation
- Can generate Logstash pipelines, but...

**Why it doesn't work:**
- No way to safely run Ansible playbooks
- No access to on-prem hardware/VMs
- No data redaction for inspection
- No integration with existing workflows (GitHub, Slack)
- No learning from mistakes
- No persistent context

**What they actually need:**
- AI ELK engineer that integrates with their GitHub, Slack, gets an email
- Learns from mistakes over time
- Debugs issues autonomously
- Maintains context across incidents
- Works observability stack (Kibana/ES interfaces)

**Who feels the pain:**
- VPs and team leads - they're the ones juggling everyone else's requests
- They know the team can't deliver fast enough
- They have the budget authority

**Why this matters:**
- This is stronger than survey data — it's lived experience
- His team is understaffed and NEEDS this
- Existing AI tools (Codex, Copilot) don't solve it
- The "AI employee" positioning is real — they'd use it today

### Key Insight (2026-03-30)
The $500 debug session doesn't sell - companies with running clusters have engineers who "should know." Better to:
- Learn from peers (free conversations)
- Consult on initial setups (companies starting fresh)
- Build agent based on real patterns

---

## Tools & Resources

### CRM Objects
- **lead:** Reddit prospects with ELK pain points
  - Fields: Title, URL, Description, Posted Date, Source, Subreddit, Status, Priority, Lead Age
  - View: Recent First (sorted by Posted Date)

### Reddit Search Strategy
- r/elasticsearch: Primary source of ELK-specific leads
- r/devops: Platform/infrastructure pain points
- r/sysadmin: Broader monitoring/logging issues

---

## Key References

### Paul Graham: Do Things That Don't Scale
**Location:** `references/paul-graham-do-things-that-dont-scale.md`

Core principles applicable to this project:
- **Manual recruitment first** — Go to users, don't wait for them to find you
- **The "Collison installation"** — Set up Stripe for users on the spot instead of sending a link
- **Small numbers compound** — 10 customers at $500 = validation, not dismissal
- **Delight first users** — Over-deliver, hand-written notes, make them feel special
- **Fragility is normal** — Airbnb went door-to-door; Reddit outreach is the same principle
- **Engineers resist this** — Want to build the AI agent, but manual debugging teaches what to build

**Applied to ELK project:**
- Manual consulting ($500/debug) → Learn patterns → Build agent → Scale

---

## Preferences & Boundaries

### What to Remember
- User prefers validation before building (minimalist approach)
- Focus on ELK-specific problems only (not generic DevOps)
- Prioritize recent leads (<30 days) for outreach
- User is technical — no need to explain ELK concepts

### What to Avoid
- Don't suggest building features without validation
- Don't recommend old/cold leads (>90 days)
- Don't dilute focus beyond ELK stack
