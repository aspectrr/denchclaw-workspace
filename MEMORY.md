# Long-Term Memory

## User Profile

### Basic Info
- **Name:** Collin
- **Role:** ELK Stack Engineer (day job)
- **Company:** OmniSock SOC (subsidiary of Indiana University)
- **Company Size:** Small team (50-500 employees range)
- **Side Project:** Building AI tool for ELK debugging/automation
- **Work Context:** SOC-as-a-service company using Elastic as SIEM
- **Availability:** Nights and weekends

### OmniSock SOC (Golden Example ICP)
**Why this is the perfect customer profile:**
- Small team where ELK is **mission-critical** — it's their core SIEM product
- Cannot afford to hire more people → needs **AI leverage** for ELK work
- Team is underwater: 70-80% of time on debugging, DLQs, Kafka lag, pipeline building
- Tried Codex/Copilot but hit walls: no safe Ansible execution, no on-prem access, no GitHub/Slack integration, no persistent context
- **This is who we're building for**

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
- **Large companies are NOT the target** (Discord, Goldman Sachs, Stripe, BBVA, Wayfair, Sophos, etc.)
- They have large platform teams, dedicated Elastic consulting, and DSE support
- Their ELK pain is one of many problems, not the core bottleneck
- **We want: small/medium company where 1-3 engineers manage ELK and it's absolutely critical**
- **OmniSock SOC is the golden example** — small team, ELK = core product, cannot hire more, needs AI leverage

**Why small-medium + mission-critical:**
- A 10-person DevOps team at a 200-person fintech where ELK goes down = business critical
- The VP/Director personally feels the pain every day
- Headcount budget exists but hiring is slow/expensive
- ELK is so central that "AI help" is a no-brainer

**KEY SIGNAL: ELK = Revenue (2026-04-01)**
- Best ICP: Companies where ELK/observability IS the product (SOC/CSOC, SIEM providers)
- At OmniSock SOC, Elastic SIEM is how they make money → mission-critical
- Look for: MSSPs, SOC-as-a-service, security companies, observability platforms
- These companies can't afford ELK downtime → AI help is purchase, not discussion

**NOT Good Fits:**
- Individual contributors without budget influence
- Contractors/C2C (temporary, no influence)
- Job seekers (leaving, can't advocate)
- IT services companies (they provide ELK support to clients)
- People at Elastic/Splunk (competitors)
- **Large enterprises with big platform teams** (Discord, Goldman, Stripe, BBVA, Wayfair, Sophos, etc.)
- Companies where ELK is "one of many tools" rather than core business
- Engineers at large companies (no influence path)

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

### 3. Lead Pipeline Status (2026-04-01)
**MAJOR CLEANUP:** Researched all 14 VP prospects and disqualified 13 based on ICP criteria.

**VP Prospect Research Results (2026-04-01):**

**QUALIFIED (1 remaining):**
- **Thomas Mark - Foresite Cybersecurity (51-200 employees)** - Director Platform Eng
  - **Why this is a HOT target:**
    - MSSP (Managed Security Services Provider) - security monitoring IS their business
    - Uses Google SecOps/SIEM - similar to OmniSock SOC's Elastic usage
    - Small team (51-200), cannot hire more → needs AI leverage
    - 95% customer retention rate, hiring security engineers
    - Perfect match for "ELK/observability = how they make money" ICP
  - LinkedIn: https://linkedin.com/in/thomasemark

**DISQUALIFIED (13 removed):**
| Company | Size | Why Not Fit |
|---------|------|-------------|
| Endeavour Group | 10,000+ | Too large, retail/drinks company |
| Accenture (Sunil Singh) | 500,000+ | Way too large, IT consulting |
| Collette Health | 51-200 | Healthcare virtual care, not observability |
| Dagster Labs | 51-200 | Data orchestration tool, not security/observability |
| Indiana Farmers Insurance | 201-500 | Insurance company, ELK not core |
| Ledger | 501-1,000 | Crypto hardware wallet, borderline |
| Project Lead The Way | 201-500 | Education nonprofit |
| SchooLinks | 51-200 | Education technology |
| Synchronoss | 501-1,000 | Cloud solutions, borderline |
| OPENLANE | 501-1,000 | Automotive/fintech, not observability core |
| Finom | Unknown | Fintech, not observability-focused |
| StoneX Group | Unknown | Financial services, not observability |
| Omar Din profile | N/A | Healthcare executive, wrong industry |

**Key Insight:** Most prospects work at companies where observability is NOT their core business. The only company where ELK/observability IS how they make money is Foresite Cybersecurity (MSSP).

**Companies in CRM (7 total):**
- OmniSock SOC - GOLDEN EXAMPLE
- TVH - Target - Hot
- ID Logistics - Target - Hot
- Ameritas - Target - Medium
- Ray Security - Target - Medium
- FRAIM - Target - Medium
- **Foresite Cybersecurity - Target - Hot (NEW)**

**Strategy Update:**
- **Focus on MSSPs, SOC-as-a-service, SIEM providers** - these are the true ICP
- Companies where "ELK/observability IS the product" → hot targets
- Continue LinkedIn outreach to find more MSSPs/security companies
- Look for: "Managed Security Services", "SOC", "SIEM", "Security Monitoring", "MSSP"

### 4. MSSP/SOC-as-a-Service Target Companies (2026-04-01)
**Research from Managed SIEM Provider Lists:**

**HOT TARGETS (51-200 employees, SIEM/SOC core business):**

| Company | Size | Notes | LinkedIn |
|---------|------|-------|----------|
| **UnderDefense** | 51-200 employees | New York, NY. MAXI platform - Agentic AI Security + Compliance. 200+ customers. SIEM/MDR/XDR. Perfect ICP. | TBD |
| **Foresite Cybersecurity** |51-200 employees | MSSP. Thomas Mark - Director Platform Eng. Google SecOps/SIEM. Perfect ICP. | https://linkedin.com/in/thomasemark |
| **Eventus Security** | TBD | Ranked #64 MSSP globally. SOC as a Service, XDR-powered. India/Saudi Arabia Cyber Defense Centers. | TBD |
| **Netsurion** | 25-500 employees | SMB focused. Co-managed SIEM via EventTracker platform. PCI DSS compliance. | TBD |
| **Alert Logic** | SMBs | AWS-focused managed SIEM. Part of Fortra. Compliance-driven. | TBD |

**BORDERLINE (might be too big):**
- **Expel** - 100-5,000 employees target - MDR, automation-first
- **Red Canary** - 200-5,000 employees target - Endpoint-focused MDR

**NOT ICP (too large):**
- Arctic Wolf - $541M revenue, 5.5K customers (too big)
- Taegis - 1,000+ employees target
- Secureworks - Large enterprise MSSP
- IBM Security, Deloitte, Accenture, EY - Giants

**Key Research Findings:**
1. **UnderDefense** is a PERFECT match - same size as Foresite, SIEM/MDR is core business, 51-200 employees
2. Managed SIEM providers are ideal because ELK/observability IS their product
3. Size: 50-500 employees is the sweet spot where they feel pain but can't hire
4. Look for "Managed Detection and Response (MDR)", "Managed SIEM", "SOC-as-a-Service"

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
