---
name: icp-research
description: "Research companies against ICP criteria for ELK/observability tools. Use when: (1) Finding companies that match ICP (MSSPs, SOC-as-a-service, SIEM providers, cybersecurity where observability IS their product), (2) Evaluating if a company fits the ideal customer profile, (3) Researching company size, business model, and ELK criticality, (4) Building prospect lists for outreach. ICP: Small-medium companies (≤200 employees) where observability/ELK is mission-critical to revenue. Use DuckDuckGo first, then PinchTab for deeper research, then LinkedIn MCP ONLY for company/people lookup (never for outreach)."
---

# ICP Research Skill

Research companies to determine if they match the Ideal Customer Profile (ICP) for ELK/observability tools. This ispurely for research—never for outreach or connecting.

## The ICP

**Golden Example: OmniSock SOC**
- Small team (51-200 employees)
- ELK/observability IS their product (SOC-as-a-service using Elastic SIEM)
- Cannot afford to hire more → needs AI leverage
- Mission-critical ELK stack (if it goes down, business stops)

**ICP Criteria:**

| Criteria | Must Have | Nice to Have |
|----------|-----------|--------------|
| Company Size | ≤200 employees (hard cap) | 51-200 optimal |
| Business Model | Observability IS the product | SIEM/MDR/MSSP/SOC |
| ELK Criticality | Mission-critical | If ELK down = revenue lost |
| Team | Small, understaffed | "Hair on fire" pressure |
| Budget | Headcount budget exists | VP/Director has authority |

**Perfect ICP Signals:**
- MSSP (Managed Security Services Provider)
- SOC-as-a-Service
- SIEM provider
- Managed Detection and Response (MDR)
- "Security monitoring is our business"
- Company URL contains: /soc, /siem, /mdr, /managed-security

**NOT ICP:**
- Large enterprises (>200 employees, especially>1,000)
- Companies where ELK is "one of many tools"
- IT services/consulting (they provide ELK support to others)
- Contractors/C2C
- Elastic/Splunk employees (competitors)
- Job seekers

## Research Workflow

### Step 1: DuckDuckGo Search (Primary)

Use `web_search` to find potential companies:

**Search queries:**```
"MSSP" "Managed SIEM" "SOC as a Service""MDR" "Managed Detection Response"
"Security Operations Center" company
"SIEM provider" small company
"Managed security services" employees
"ELK stack" "Security monitoring" company
```

**Extract from results:**
- Company name
- Website URL
- Company description (what do they DO?)
- Size hints (team size, number of customers)
- Business model (MSSP? SOC? SIEM?)

### Step 2: PinchTab (If DuckDuckGo Insufficient)

Use PinchTab when:
- DuckDuckGo results lack detail
- Need to visit company website for business model clarity
- Need to find employee count on website/LinkedIn

**PinchTab workflow:**
```
1. pinchtab_navigate({ url: "company-website.com" })
2. pinchtab_wait_for_load({ load: "networkidle" })
3. pinchtab_get_text() or pinchtab_screenshot()
4. Look for: About page, Team page, Careers, "What we do"
```

### Step 3: LinkedIn MCP (Company Details Only)

**CRITICAL: This is RESEARCH ONLY. Never connect, message, or outreach.**

Use LinkedIn MCP `get_company_profile` to verify:
- Employee count (confirm ≤200)
- Company description
- Industry (SIEM/cybersecurity/managed services)
- Headquarters location

**LinkedIn workflow:**
```
mcp action=call server=linkedin-mcp tool=get_company_profile params={ name_or_id: "Company Name" }
```

**What to extract:**
- `employee_count` → Must be ≤200
- `description` → SIEM/MDR/MSSP keywords?
- `industries` → Cybersecurity/IT services?
- `specialties` → Managed security, SIEM, SOC?

**DO NOT:**
- Use `search_people` to find contacts (research only)
- Use `send_message` or `send_invitation`
- Connect with anyone

## ICP Match Scoring

After research, score each company:

### Score Card

| Factor | Weight | Score 0-5 |
|--------|--------|-----------|
| Company Size (≤200) | 25% | 5=≤200, 3=201-500, 0=>500 |
| Business Model Match | 30% | 5=SIEM/MSSP/SOC, 3=Security adj, 0=Unrelated |
| ELK Criticality | 25% | 5=Observability IS product, 3=Critical internal, 1=Nice-to-have |
| Team Pressure | 20% | 5="Hair on fire", 3=Understaffed, 1=Stable |

**Total Score:**
- **20-25: HOT** → Perfect ICP, prioritize for outreach
- **15-19: Good Fit** → Strong match, proceed with research
- **10-14: OK Fit** → Investigate further before deciding
- **0-9: NOT ICP** → Disqualify

## Output Format

For each researched company, provide:

```markdown
## Company Name

**ICP Score:** XX/25 (HOT/Good/OK/Not ICP)

### Match Criteria
| Criteria | Status | Evidence |
|----------|--------|----------|
| Size | ✅/❌ | Employee count, source |
| Business Model | ✅/❌ | What they sell |
| ELK Criticality | ✅/❌ | How critical observability is |
| Team Pressure | ?/? | Unknown without conversation |

### Business Model
- [What the company actually does]
- [Whether observability/ELK is their revenue source]

### Size Verification
- Employees: [count] (Source: LinkedIn/website)
- Fits ICP: Yes/No

### Recommendation
[Hot/Research More/Disqualified] - [Reason]

### Sources
- Website: [URL]
- LinkedIn: [URL]- DuckDuckGo: [Search query used]
```

## Common Patterns

### Hot Targets (Score 20-25)
```
- MSSPs with 50-200 employees
- SOC-as-a-Service providers
- Managed SIEM companies
- Security monitoring is their primary revenue
```

### Borderline (Score 15-19)
```
- Larger MSSPs (200-500 employees) - may have big platform teams
- Security-adjacent companies (configurations, compliance)
- Companies using ELK internally but not selling it
```

### NOT ICP (Score 0-9)
```
- Enterprise companies (>1,000 employees)
- Companies where ELK is one of 20 tools
- IT consulting firms (they sell services, not monitoring)
- Pure software companies (observability is overhead, not product)
```

## Disqualification Examples

| Company | Why Disqualified |
|--------|------------------|
| Discord | Too large (500+), platform team has DSE support |
| Accenture | IT consulting, not MSSP product |
| Dagster Labs | Data orchestration tool, not security/observability |
| Insurance Company | Insurance is their business, ELK is internal |

## Remember

1. **Research = Golden Example**: Compare every company to OmniSock SOC
2. **Business ModelMatters**: "Do they SELL observability?" > "Do they USE observability?"
3. **Size is Hard Cap**: >200 employees = disqualified
4. **LinkedIn is READ-ONLY**: Never connect or outreach during research
5. **Score Before Deciding**: Don't guess—use the scorecard

## Quick Reference

### DuckDuckGo Search Terms
```
"MSSP" "Managed SIEM" "SOC as a Service" 
"MDR" "Managed Detection Response"
"Security Operations Center" company
"SIEM provider" small
"Managed security" 51-200 employees
```

### LinkedIn MCP Tools (Research Only)
```
get_company_profile → Verify size, industry, description
```

### PinchTab Use Cases
```
1. Company website About page → Business model
2. Team/Careers page → Size hints
3. Service pages → SIEM/MDR/SOC keywords
```