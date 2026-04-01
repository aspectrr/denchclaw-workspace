---
name: icp-engineer
description: "Find and connect with engineers working on ELK/observability stacks at ICP companies. Use when: (1) Researching individual contributors at a company that passed ICP company research, (2) Finding engineers with ELK/platform/SRE skills, (3) Verifying someone's work involves ELK/logstash/observability, (4) Connecting with practitioners who manage the stack day-to-day. Workflow: Company from CRM → DuckDuckGo → PinchTab → LinkedIn MCP (verify ELK in skills/experience + connect) → Add to engineers CRM. This skill DOES connect on LinkedIn."
---

# ICP Engineer Skill

Find and connect with engineers working hands-on with ELK/observability stacks at ICP companies. These are the practitioners who debug pipelines, manage Kafka lag, and feel the pain daily.

## Who You're Looking For

**Target Titles:**
- ELK Stack Engineer
- Platform Engineer
- SRE / Site Reliability Engineer
- Infrastructure Engineer
- DevOps Engineer (with observability focus)
- Observability Engineer
- Logstash Engineer
- Data Pipeline Engineer
- Monitoring Engineer

**Key Signals (Look for ELK-Related):**

**Strong Signals:**
- Skills: Elasticsearch, Logstash, Kibana, ELK, Elastic
- Experience: "Manage ELK stack", "Build logstash pipelines", "Elasticsearch infrastructure"
- Certifications: Elastic Certified, etc.

**Good Signals:**
- Skills: Observability, monitoring, logging, Prometheus, Grafana
- Experience: "Platform engineering", "Data pipelines", "Log aggregation"
- Title: Platform Engineer, SRE, Infrastructure Engineer

**Related Signals (Bonus):**
- Kafka, Redis, distributed systems
- On-call, incident response
- An infrastructure, reliability

**Why These People:**
- They **feel the pain daily** (debugging, on-call, incidents)
- They **know the stack** and can validate the problem
- They can **advocate internally** to their VP/Director
- They're often **asked for opinions** on tooling decisions

## Prerequisites

**Before using this skill:**
1. Company must pass ICP company research (use `icp-company-research` skill first)
2. Company should be in the `companies` CRM with Status = "Target" or "Hot"
3. Have company name ready for research

## Research Workflow

### Step 1: Get Company from CRM

Query the companies CRM to find the company you're researching:

```sql
SELECT * FROM v_companies WHERE Status IN ('Target', 'Hot')
```

Note the company name and any LinkedIn URL.

### Step 2: DuckDuckGo Search

Find potential engineers at the company:

**Search queries:**
```
"[Company Name]" "ELK" "engineer" LinkedIn
"[Company Name]" "Elasticsearch" "infrastructure" LinkedIn
"[Company Name]" "platform engineer" LinkedIn
"[Company Name]" "SRE" "observability" LinkedIn
"[Company Name]" "Logstash" "engineer" LinkedIn
"[Company Name]" "monitoring" "infrastructure" LinkedIn
```

**Extract from results:**
- Person name
- Title
- LinkedIn profile URL
- Company name

### Step 3: PinchTab (If Needed)

Use PinchTab when:
- DuckDuckGo results are thin
- Company has engineering blog or team page
- Need to find engineers from company website

**PinchTab workflow:**
```
1. pinchtab_navigate({ url: "company-website.com/engineering" })
2. pinchtab_wait_for_load({ load: "networkidle" })
3. pinchtab_get_text() - Look for engineering team page
4. Find names and titles of platform/infrastructure engineers
```

### Step 4: LinkedIn MCP (Primary Research)

**This is the main tool for engineer research.**

#### 4A: Search for People at Company

```
mcp action=call server=linkedin-mcp tool=search_people params={
  keywords: "ELK Elasticsearch Logstash platform engineer SRE observability",
  company: "[Company Name]"
}
```

**Filter for:**
- Titles matching target list (Engineer, SRE, Platform)
- Current role (not past employees)
- Location (optional)

#### 4B: Get Person Profile

For each candidate, get full profile:

```
mcp action=call server=linkedin-mcp tool=get_person_profile params={
  public_identifier: "[LinkedIn ID or URL]"
}
```

**Analyze for ELK relevance:**

**Strong Match:**
- Skills: Elasticsearch, Logstash, Kibana, ELK, Elastic ✅
- Experience: "Manage ELK stack", "Build logstash pipelines", "Elasticsearch clusters" ✅
- Title: ELK Engineer, Platform Engineer (with ELK), SRE (with observability) ✅

**Good Match:**
- Skills: Observability, monitoring, logging, Prometheus, Grafana ✅
- Experience: Platform engineering, data pipelines, log aggregation ✅
- Title: Platform Engineer, SRE, Infrastructure Engineer ✅

**Weak Match:**
- Skills: DevOps, CI/CD, general infrastructure
- Experience: Backend engineering, general platform work
- Need more research to confirm ELK involvement

#### 4C: Verify Right Person

**Strong Match (Connect Immediately):**
- Title: ELK Engineer, Platform Engineer, SRE, Infrastructure Engineer
- Skills: Elasticsearch, Logstash, Kibana, or ELK mentioned
- Experience: Hands-on with ELK stack, log pipelines, observability
- Company: Verified ICP

**Good Match (Connect):**
- Title: Platform Engineer, SRE, Infrastructure Engineer
- Skills: Observability, monitoring, logging
- Experience: Platform engineering, data pipelines
- Company: Verified ICP

**Research Needed (Add for Follow-up):**
- Title indicates platform/infrastructure but unclear ELK involvement
- Need to verify hands-on work

**Not a Match (Skip):**
- Title doesn't indicate platform/infrastructure/engineering
- No ELK or observability relevance
- Backend/Frontend focused (not infrastructure)
- Left company or role changed

### Step 5: Connect on LinkedIn

**Connect with Strong and Good Matches.**

```
mcp action=call server=linkedin-mcp tool=send_invitation params={
  profile_id: "[LinkedIn ID]",
  message: "" // Blank connection request (no message)
}
```

**Connection Rules:**
- Send **blank** connection requests (no note)
- Connect with **Strong and Good Matches**
- If connection fails or uncertain, add to CRM with Status = "Not Connected"

### Step 6: Add to CRM

Add to `engineers` object with all research:

**Required Fields:**
- Name
- Title
- Company
- LinkedIn URL
- Status: Connected / Pending / Not Connected
- Match Quality: Strong / Good / Weak
- ELK Relevance: Yes / No / Maybe
- Skills: Elasticsearch, Logstash, Kibana, etc.
- Notes: What makes them a good fit

**Example entry:**
```markdown
Name: Jane Smith
Title: Senior Platform Engineer
Company: Foresite Cybersecurity
LinkedIn: https://linkedin.com/in/janesmith
Status: Connected
Match Quality: Strong
ELK Relevance: Yes - Elasticsearch, Logstash, Kibana in skills
Skills: Elasticsearch, Logstash, Kibana, Kafka, Prometheus
Notes: Perfect ICP. Builds logstash pipelines, manages ES clusters for MSSP.
```

## Match Scoring

### Strong Match (Connect Immediately)
- [x] Title: ELK Engineer, Platform Engineer, SRE, Infrastructure Engineer
- [x] Skills: Elasticsearch, Logstash, Kibana, or ELK mentioned
- [x] Experience: Hands-on with ELK stack
- [x] Company is verified ICP

**Action:** Connect on LinkedIn + Add to CRM (Status: Connected)

### Good Match (Connect)
- [x] Title: Platform Engineer, SRE, Infrastructure Engineer
- [x] Skills: Observability, monitoring, logging
- [x] Experience: Platform engineering, data pipelines
- [x] Company is verified ICP

**Action:** Connect on LinkedIn + Add to CRM (Status: Connected)

### Weak Match (Add for Tracking)
- [x] Title indicates technical role
- [?] Unclear ELK/observability involvement
- [x] Company is ICP

**Action:** Add to CRM (Status: Not Connected, Match Quality: Weak)

**Follow-up:** Research deeper to confirm ELK work.

### Not a Match (Skip)
- [ ] Title not related to platform/infrastructure/engineering
- [ ] No ELK or observability relevance
- [ ] Wrong focus (Backend/Frontend, not infrastructure)
- [ ] Left company

**Action:** Skip, don't add to CRM.

## CRM Object: engineers

**Fields:**
| Field | Type | Description |
|-------|------|-------------|
| Name | Short Text | Person's full name |
| Title | Short Text | Current job title |
| Company | Link | Link to companies object |
| LinkedIn URL | URL | LinkedIn profile |
| Status | Select | Not Connected / Pending / Connected / Rejected |
| Match Quality | Select | Strong / Good / Weak |
| ELK Relevance | Select | Yes / No / Maybe |
| Skills | Multi-Select | Elasticsearch, Logstash, Kibana, Kafka, etc. |
| Experience Notes | Long Text | Relevant experience excerpt |
| Notes | Long Text | Research notes, why they're a fit |

## LinkedIn MCP Tools Reference

| Tool | Purpose | When to Use |
|------|---------|-------------|
| `search_people` | Find people by keywords/company | Initial search for candidates |
| `get_person_profile` | Full profile details | Verify ELK in experience/skills |
| `send_invitation` | Connect on LinkedIn | Strong/Good matches, blank message |
| `get_company_profile` | Company details | Verify company size/industry |

## Common Scenarios

### Found Multiple Engineers
```
Query company → 3 potential contacts:
1. ELK Stack Engineer (Strong Match - ELK in skills) → Connect
2. Platform Engineer (Good Match - observability experience) → Connect
3. DevOps Engineer (Weak Match - no ELK mention) → Add for tracking
```

### Can't Connect (LinkedIn Limit)
```
1. Add to CRM with Status: Not Connected
2. Notes: "Connection limit reached, retry later"
3. Prioritize Strong matches for retry
```

### Person Left Company
```
1. Check if new company is ICP → potentially recycle
2. If not ICP → skip
3. Don't add wrong company to CRM
```

### Unclear if ELK Engineer
```
1. Add to CRM with Match Quality: Weak
2. Notes: "Need to verify if hands-on with ELK"
3. Look for better contact or check skills more carefully
```

## Output Format

For each engineer researched:

```markdown
## [Name]

**Title:** [Current title]
**Company:** [Company name]
**LinkedIn:** [Profile URL]

### Match Assessment
| Criteria | Status | Evidence |
|----------|--------|----------|
| Title Match | ✅/⚠️/❌ | [Title] |
| ELK Skills | ✅/⚠️/❌ | [Skills listed] |
| ELK Experience | ✅/⚠️/❌ | [Where ELK appears] |
| Company ICP | ✅/⚠️/❌ | [ICP status] |

### Skills Found
- [Skills from profile: Elasticsearch, Logstash, Kibana, etc.]

### Experience Highlights
- [Relevant experience excerpt]
- [Key projects/achievements]

### Action
- **Status:** Connected / Pending / Not Connected
- **Match Quality:** Strong / Good / Weak
- **CRM:** Added / Skipped

### Notes
[Any additional context]
```

## Remember

1. **Company First:** Only research engineers at companies that passed ICP company research
2. **ELK Signals:** Look for Elasticsearch, Logstash, Kibana, ELK in skills AND experience
3. **Hands-On:** These are practitioners, not managers—title should be Engineer/SRE, not VP/Director
4. **Connect with Strong + Good Matches:** Blank connection requests
5. **Add Everyone to CRM:** Even weak matches for future tracking
6. **Status Tracking:** Track connection status for follow-up

## Quick Reference

### DuckDuckGo Search Terms
```
"[Company]" "ELK" "engineer" LinkedIn
"[Company]" "Elasticsearch" "infrastructure" LinkedIn
"[Company]" "platform engineer" LinkedIn
"[Company]" "SRE" "observability" LinkedIn
"[Company]" "Logstash" "engineer" LinkedIn
```

### LinkedIn MCP Tools
```
search_people → Find candidates by title/skills/company
get_person_profile → Verify ELK in experience/skills
send_invitation → Connect (Strong/Good matches, blank message)
```

### Title Keywords
```
ELK Engineer, Platform Engineer, SRE, Infrastructure Engineer,
DevOps Engineer, Observability Engineer, Logstash Engineer,
Data Pipeline Engineer, Monitoring Engineer, Reliability Engineer
```

### Skills to Look For
```
Elasticsearch, Logstash, Kibana, ELK, Elastic(Strong signals)
Observability, monitoring, logging, pipelines (Good signals)
Kafka, Prometheus, Grafana, distributed systems (Related)
```

### Experience Keywords
```
"Manage ELK stack", "Build logstash pipelines", "Elasticsearch clusters",
"Log aggregation", "Data pipelines", "Observability platform",
"Platform engineering", "On-call", "Incident response"
```