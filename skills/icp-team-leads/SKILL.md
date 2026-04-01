---
name: icp-team-leads
description: "Find and connect with team leads/VPs running observability/ELK stacks at ICP companies. Use when: (1) Researching decision-makers at a company that passed ICP company research, (2) Finding VP/Director/Team Lead contacts (VP Platform, Director SRE, Infrastructure Lead), (3) Verifying someone's role includes observability/platform, (4) Connecting with buyers who have budget authority. Workflow: Company from CRM → DuckDuckGo → PinchTab → LinkedIn MCP (verify + connect) → Add to team_leads CRM. Look for observability/platform/infrastructure in experience. This skill DOES connect on LinkedIn."
---

# ICP Team Leads Skill

Find and connect with team leads/VPs who run observability/ELK stacks at ICP companies. These are your buyers—they have budget authority and feel the pain directly.

## Who You're Looking For

**Target Titles:**
- VP of Platform / VP of Infrastructure
- Director of SRE / Director of Platform / Director of Infrastructure
- Platform Team Lead / Observability Team Lead
- Engineering Manager (Platform/Observability)
- Head of Infrastructure

**Key Signals (Look for ANY ofThese):**

**Primary (Decision-Maker Signals):**
- Title indicates platform/infrastructure/SRE leadership
- Manages team responsible for observability
- Budget authority (hiring, toolingdecisions)

**Bonus (Stronger Match):**
- Experience mentions: ELK, Elasticsearch, observability platform
- Skills: Elasticsearch, monitoring, logging, observability
- Bio: Platform infrastructure, uptime, reliability

**Why These People:**
- They have **budget authority** (headcount budget, not tooling budget)
- They feel the **pain directly** (team can't deliver fast enough)
- They're **understaffed** but can't hire quickly
- ELK/observability is **mission-critical** to their success

**Note:** Team leads may not have "ELK" explicitly in their profile—they manage the team, not necessarily hands-on with the stack. Look for: observability, platform, infrastructure, SRE, reliability, uptime.

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

Find potential team leads at the company:

**Search queries:**
```
"[Company Name]" "VP Platform" LinkedIn
"[Company Name]" "Director SRE" LinkedIn
"[Company Name]" "Platform Team Lead" LinkedIn
"[Company Name]" "observability" "engineering manager" LinkedIn
"[Company Name]" "infrastructure" "director" LinkedIn
```

**Extract from results:**
- Person name
- Title
- LinkedIn profile URL
- Company name

### Step 3: PinchTab (If Needed)

Use PinchTab when:
- DuckDuckGo results are thin
- Need to browse company team/leadership page
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
  keywords: "VP Platform Director SRE Team Lead infrastructure observability",
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

**Analyze for relevance:**
- **Title:** VP/Director/Lead/Manager of Platform/SRE/Infrastructure ✅
- **Experience:** Platform, observability, infrastructure, reliability ✅ (ELK = bonus)
- **Skills:** Monitoring, observability, reliability ✅ (ELK = bonus)
- **Bio:** Platform infrastructure, uptime, reliability ✅

#### 4C: Verify Right Person

**Strong Match (Connect Immediately):**
- Title: VP of Platform, Director of SRE, Platform Team Lead
- Experience: Platform, observability, infrastructure (ELK mentioned = bonus)
- Skills: Monitoring, observability, reliability (ELK = bonus)
- Company: Verified ICP

**Good Match (Add and Connect):**
- Title matches target list
- Experience mentions platform/infrastructure
- Company is ICP

**Research Needed (Add for Follow-up):**
- Title indicates leadership but unclear scope
- Need to verify they manage observability/team

**Not a Match (Skip):**
- Title doesn't indicate platform/infrastructure leadership
- No relevant experience
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

Add to `team_leads` object with all research:

**Required Fields:**
- Name
- Title
- Company
- LinkedIn URL
- Status: Connected / Pending / Not Connected
- Match Quality: Strong / Good / Weak
- Platform Relevance: Yes / No / Maybe
- Notes: What makes them a good fit

**Example entry:**
```markdown
Name: Thomas Mark
Title: Director Platform Engineering
Company: Foresite Cybersecurity
LinkedIn: https://linkedin.com/in/thomasemark
Status: Connected
Match Quality: StrongPlatform Relevance: Yes - Runs platform team for MSSP
Notes: Perfect ICP. Director of platform at MSSP, observability is core business.
```

## Match Scoring

### Strong Match (Connect Immediately)
- [x] Title: VP/Director/Lead/Manager of Platform/SRE/Infrastructure
- [x] Experience: Platform, observability, infrastructure mentioned
- [+] ELK mentioned = bonus signal (not required)
- [x] Company is verified ICP

**Action:** Connect on LinkedIn + Add to CRM (Status: Connected)

### Good Match (Connect)
- [x] Title matches target list
- [x] Experience indicates platform/infrastructure role
- [x] Company is verified ICP

**Action:** Connect on LinkedIn + Add to CRM (Status: Connected)

### Weak Match (Add for Tracking)
- [x] Title is close (Engineering Manager, but not platform-specific)
- [?] Unclear if they manage observability/team
- [x] Company is ICP

**Action:** Add to CRM (Status: Not Connected, Match Quality: Weak)

**Follow-up:** Research deeper or look for better contact.

### Not a Match (Skip)
- [ ] Title doesn't indicate platform/infrastructure leadership
- [ ] No relevant experience
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
| Platform Relevance | Select | Yes / No / Maybe |
| Experience Notes | Long Text | Relevant experience excerpt |
| Skills | Multi-Select | Platform, observability, infrastructure, etc. |
| Notes | Long Text | Research notes, why they're a fit |

## LinkedIn MCP Tools Reference

| Tool | Purpose | When to Use |
|------|---------|-------------|
| `search_people` | Find people by keywords/company | Initial search for candidates |
| `get_person_profile` | Full profile details | Verify role, experience |
| `send_invitation` | Connect on LinkedIn | Strong/Good matches, blank message |
| `get_company_profile` | Company details | Verify company size/industry |

## Common Scenarios

### Found Multiple Team Leads
```
Query company → 3 potential contacts:
1. VP Platform (Strong Match - platform experience) → Connect
2. Director SRE (Good Match - SRE leadership) → Connect
3. Engineering Manager (Weak Match - unclear scope) → Add, don't connect
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

### Unclear if Right Person
```
1. Add to CRM with Match Quality: Weak
2. Notes: "Need to verify if they manage observability/team"
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
| Platform Relevance | ✅/⚠️/❌ | [Platform/observability mention] |
| Company ICP | ✅/⚠️/❌ | [ICP status] |
| ELK Mention | +/— | [If mentioned, where] |

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
2. **ELK is Bonus:** Team leads may not have ELK explicitly—look for platform/observability/infrastructure
3. **Title Matters:** VP/Director/Lead/Manager of Platform/SRE = buying power
4. **Connect with Strong +Good Matches:** Blank connection requests
5. **Add Everyone to CRM:** Even weak matches for future tracking
6. **Status Tracking:** Track connection status for follow-up

## Quick Reference

### DuckDuckGo Search Terms
```
"[Company]" "VP Platform" LinkedIn
"[Company]" "Director SRE" LinkedIn
"[Company]" "Platform Team Lead" LinkedIn
"[Company]" "infrastructure" "director" LinkedIn
"[Company]" "observability" "engineering manager" LinkedIn
```

### LinkedIn MCP Tools
```
search_people → Find candidates by title/company
get_person_profile → Verify platform/observability in experience
send_invitation → Connect (Strong/Good matches, blank message)
```

### Title Keywords
```
VP Platform, VP Infrastructure, Director SRE, Director Platform,
Platform Team Lead, Observability Lead, Engineering Manager Platform,
Head of Infrastructure, SRE Lead, Infrastructure Manager
```

### Experience Keywords (Any of These)
```
platform, observability, infrastructure, reliability, SRE,
uptime, monitoring, logging, availability, distributed systems
(ELK/Elasticsearch are bonus signals, not required)
```