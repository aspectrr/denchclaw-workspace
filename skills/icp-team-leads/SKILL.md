---
name: icp-team-leads
description: "Find and connect with team leads/VPs running ELK/observability stacks at ICP companies. Use when: (1) Researching contacts at a company that passed ICP company research, (2) Finding the right person to reach out to (VP Platform, Director SRE, Team Lead), (3) Verifying someone's role includes ELK/observability, (4) Connecting with decision-makers on LinkedIn. Workflow: Company from CRM → DuckDuckGo → PinchTab → LinkedIn MCP (verify + connect) → Add to team_leads CRM. Look for ELK in experience/skills. This skill DOES connect on LinkedIn."
---

# ICP Team Leads Skill

Find and connect with team leads/VPs who run ELK/observability stacks at ICP companies. These are your buyers—they have budget authority and feel the pain directly.

## Who You're Looking For

**Target Titles:**
- VP of Platform / VP of Infrastructure
- Director of SRE / Director of Platform / Director of Infrastructure
- Platform Team Lead / Observability Team Lead
- Engineering Manager (Platform/Observability)
- Head of Infrastructure

**Key Signals (Look for ELK in):**
- Experience → "Manage ELK stack", "Built observability platform", "Elasticsearch infrastructure"
- Skills → Elasticsearch, Logstash, Kibana, ELK, Elastic, observability, monitoring
- Bio → Mentions ELK, observability, logging infrastructure

**Why These People:**
- They have **budget authority** (headcount budget, not tooling budget)
- They feel the **pain directly** (team can't deliver fast enough)
- They're **understaffed** but can't hire quickly
- ELK is **mission-critical** to their success

## Prerequisites

**Before using this skill:**
1. Company must pass ICP company research (use `icp-company-research` skill first)
2. Company should be in the `companies` CRM with Status = "Target" or "Hot"
3. Have company LinkedIn URL ready for research

## Research Workflow

### Step 1: Get Company from CRM

Query the team_leads or companies CRM to find the company you're researching:

```sql
SELECT * FROM v_companies WHERE Status IN ('Target', 'Hot')
```

Note the company name and any LinkedIn URL.

### Step 2: DuckDuckGo Search

Find potential team leads at the company:

**Search queries:**
```
"[Company Name]" "VP Platform" LinkedIn
"[Company Name]" "Director SRE" LinkedIn
"[Company Name]" "Platform Team Lead" LinkedIn
"[Company Name]" "observability" "engineering manager" LinkedIn
"[Company Name]" "Elasticsearch" "infrastructure" LinkedIn
```

**Extract from results:**
- Person name
- Title
- LinkedIn profile URL
- Company name

### Step 3: PinchTab (If Needed)

Use PinchTab when:
- DuckDuckGo results are thin
- Need to browse company team page
- Need to find LinkedIn profiles from company website

**PinchTab workflow:**
```
1. pinchtab_navigate({ url: "company-website.com/team" })
2. pinchtab_wait_for_load({ load: "networkidle" })
3. pinchtab_get_text() - Look for leadership/team page
4. Find names and titles of platform/infrastructure leaders
```

### Step 4: LinkedIn MCP (Primary Research)

**This is the main tool for team lead research.**

#### 4A: Search for People at Company

```
mcp action=call server=linkedin-mcp tool=search_people params={
  keywords: "VP Platform Director SRE Team Lead infrastructure",
  company: "[Company Name]"
}
```

**Filter for:**
- Titles matching target list (VP, Director, Lead, Manager)
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
- **Experience:** Look for ELK/Elasticsearch/observability mentions
- **Skills:** Check for Elasticsearch, Logstash, Kibana, monitoring
- **Bio:** Mentions of logging, observability, infrastructure
- **Current role:** Title should be VP/Director/Lead/Manager

#### 4C: Verify Right Person

**Strong Match (Add + Connect):**
- Title: VP of Platform, Director of SRE, Platform Team Lead
- Experience: "Manage ELK stack", "Built observability platform"
- Skills: Elasticsearch, Kibana, observability
- Company: ICP company (already verified)

**Weak Match (Add but Don't Connect):**
- Title matches but no ELK mention
- Engineering lead but unclear if they run observability
- Need more research to confirm

**Not a Match (Skip):**
- Title doesn't indicate platform/infrastructure
- No ELK/observability in profile
- Left company or role changed

### Step 5: Connect on LinkedIn

**ONLY connect with Strong Matches.**

```
mcp action=call server=linkedin-mcp tool=send_invitation params={
  profile_id: "[LinkedIn ID]",
  message: "" // Blank connection request (no message)
}
```

**Connection Rules:**
- Send **blank** connection requests (no note)
- Only connect with **Strong Matches** (ELK in profile)
- If connection fails or uncertain, add to CRM with Status = "Not Connected"

### Step 6: Add to CRM

Add to `team_leads` object with all research:

**Required Fields:**
- Name
- Title
- Company
- LinkedIn URL
- Status: Connected / Pending / Not Connected
- Match Quality: Strong / Weak / Research
- ELK Relevance: Yes / No / Maybe
- Notes: What makes them a good fit (or not)

**Example entry:**
```markdown
Name: Thomas Mark
Title: Director Platform Engineering
Company: Foresite Cybersecurity
LinkedIn: https://linkedin.com/in/thomasemark
Status: Connected
Match Quality: Strong
ELK Relevance: Yes - Google SecOps/SIEM, platform engineering
Notes: Perfect ICP. MSSP, runs platform team, observability is core business.
```

## Match Scoring

### Strong Match (Connect Immediately)
- [x] Title: VP/Director/Lead/Manager of Platform/SRE/Infrastructure
- [x] Experience mentions ELK/Elasticsearch/observability
- [x] Skills include Elasticsearch, monitoring, or similar
- [x] Company is verified ICP

**Action:** Connect on LinkedIn + Add to CRM (Status: Connected)

### Good Match (Research More)
- [x] Title matches target list
- [?] No clear ELK mention, but company uses ELK
- [x] Company is verified ICP

**Action:** Add to CRM (Status: Not Connected, Match Quality: Good)

**Follow-up:** Use PinchTab to research their background more, or check company tech stack.

### Weak Match (Add for Tracking)
- [x] Title is close (Engineering Manager, but not platform)
- [?] Unclear if they manage ELK/observability
- [x] Company is ICP

**Action:** Add to CRM (Status: Not Connected, Match Quality: Weak)

**Follow-up:** Look for better contact or get introduction.

### Not a Match (Skip)
- [ ] Title doesn't indicate platform/infrastructure leadership
- [ ] No ELK/observability relevance
- [ ] Left company

**Action:** Skip, don't add to CRM.

## CRM Object: team_leads

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
| Experience Notes | Long Text | Relevant experience excerpt |
| Skills | Multi-Select | Elasticsearch, Logstash, Kibana, monitoring, etc. |
| Notes | Long Text | Research notes, why they're a fit |

## LinkedIn MCP Tools Reference

| Tool | Purpose | When to Use |
|------|---------|-------------|
| `search_people` | Find people by keywords/company | Initial search for candidates |
| `get_person_profile` | Full profile details | Verify ELK relevance, get title |
| `send_invitation` | Connect on LinkedIn | Strong matches only |
| `get_company_profile` | Company details | Verify company size/industry |

## Common Scenarios

### Found Multiple Team Leads
```
Query company → 3 potential contacts:
1. VP Platform (Strong Match - ELK in skills) → Connect
2. Director SRE (Good Match - platform role, no ELK mention) → Add, don't connect
3. Engineering Manager (Weak Match - unclear) → Add for tracking
```

### Can't Connect (LinkedIn Limit)
```
1. Add to CRM with Status: Not Connected
2. Notes: "Connection limit reached, retry later" or "LinkedIn blocked connection"
3. Prioritize Strong matches for retry
```

### Person Left Company
```
1. Check if new company is ICP → potentially recycle
2. If not ICP → skip
3. Don't add wrong company to CRM
```

### Unclear if Right Person
```
1. Add to CRM with Match Quality: Weak
2. Notes: "Need to verify if they manage ELK/observability"
3. Look for better contact or research deeper
```

## Output Format

For each team lead researched:

```markdown
## [Name]

**Title:** [Current title]
**Company:** [Company name]
**LinkedIn:** [Profile URL]

### Match Assessment
| Criteria | Status | Evidence |
|----------|--------|----------|
| Title Match | ✅/⚠️/❌ | [Title] |
| ELK Relevance | ✅/⚠️/❌ | [Where ELK appears] |
| Company ICP | ✅/⚠️/❌ | [ICP status] |

### Experience Highlights
- [Relevant experience excerpt]
- [Key skills mentioned]

### Action
- **Status:** Connected / Pending / Not Connected
- **Match Quality:** Strong / Good / Weak
- **CRM:** Added / Skipped

### Notes
[Any additional context]
```

## Remember

1. **Company First:** Only research team leads at companies that passed ICP company research
2. **ELK Signals:** Look for ELK/Elasticsearch/observability in experience and skills
3. **Title Matters:** VP/Director/Lead/Manager of Platform/SRE = buying power
4. **Connect with Strong Matches:** Blank connection requests only
5. **Add Everyone to CRM:** Even weak matches for future tracking
6. **Status Tracking:** Track connection status for follow-up

## Quick Reference

### DuckDuckGo Search Terms
```
"[Company]" "VP Platform" LinkedIn"[Company]" "Director SRE" LinkedIn
"[Company]" "observability" "engineering" LinkedIn
"[Company]" "Elasticsearch" "infrastructure" LinkedIn
```

### LinkedIn MCP Tools
```
search_people → Find candidates by title/company
get_person_profile → Verify ELK in experience/skills
send_invitation → Connect (Strong matches only, blank message)
```

### Title Keywords
```
VP Platform, VP Infrastructure, Director SRE, Director Platform,
Platform Team Lead, Observability Lead, Engineering Manager Platform,
Head of Infrastructure, SRE Lead
```

### ELK Keywords to Look For
```
Elasticsearch, Logstash, Kibana, ELK, Elastic,
observability, monitoring, logging infrastructure,
"manage ELK", "build observability platform"
```