# SKILL.md — VP Prospect Research Workflow

End-to-end workflow for identifying, researching, and loading VP/Director-level platform engineering prospects into the CRM.

## Overview
This workflow combines:
1. **Company Research** (PinchTab) — Find companies with ELK/platform pain
2. **Prospect Research** (LinkedIn MCP) — Find decision-makers at those companies
3. **CRM Loading** — Add prospects with full context

## Target Prospect Profile
**ICP: VP and Team Leads responsible for understaffed ELK/platform teams**

```
MUST HAVE:
- Title: VP of Platform / VP of Infrastructure / VP of Engineering / Director of SRE / 
  Director of Platform Engineering / Senior Director of Engineering (platform focus) /
  Platform Team Lead / Engineering Manager (Platform/DevOps/SRE/Observability)
- Company size: 50-10,000+ employees
- Company runs self-managed ELK (not Elastic Cloud)
- NOT: job seeker, contractor, competitor, IT services company

PREFER:
- Company in: Fintech, Cybersecurity, E-commerce, Logistics, Healthcare, Media/Gaming, Telecom
- Explicit ELK/Elasticsearch mention in profile
- Active poster (last 90 days)
- 1st or 2nd connection degree
```

## Workflow

### Phase 1: Identify Target Companies (PinchTab)

Use PinchTab to research companies in priority verticals:

**Step 1a: Elastic.co Customers (start here — highest signal)**
```
Navigate to: https://www.elastic.co/customers
```
Read the case studies for:
- TVH (logistics, industrial) — "platform team was a bottleneck"
- BBVA (banking) — 150-node Elastic cluster
- Brazilian Telecom — 5K hosts, exploring AI incident analysis
- ID Logistics — 60% cost reduction with Elastic

Click through to individual case studies and extract:
- Pain language (exact quotes)
- Company size and industry
- Decision-maker name/title if listed
- Cluster/data volume

**Step 1b: Target Engineering Blogs**
For specific companies, navigate to their engineering blog:
- Discord: `https://discord.com/blog` — search for "ELK", "Elasticsearch", "indexing"
- Stripe: `https://stripe.com/blog/engineering` — platform engineering posts
- Others: `https://engineering.{company}.com`

**Step 1c: Job Postings (optional)**
If company research is thin, check LinkedIn job postings:
```
Navigate to: https://www.linkedin.com/work/search?keywords=Senior+Platform+Engineer+ELK+{company}
```
Hiring signals = understaffing = pain.

### Phase 2: Find Decision-Makers (LinkedIn MCP)

**Step 2a: Search for Prospects**
Use `search_people` for each target company:
```
Keywords: "VP Director Platform Engineering SRE {CompanyName}"
```
If no results, broaden:
```
Keywords: "VP Director Platform Engineering SRE"
```
And filter results to the target company from the profile.

**Step 2b: Profile Each Prospect**
Use `get_person_profile` for the top 5-10 results. Look for:
- [ ] Title matches ICP (VP/Director/Senior Director/Manager of Platform/SRE/Infrastructure)
- [ ] Connection degree: 1st or 2nd = ideal; 3rd+ = follow-only
- [ ] Connect button available (not follow-only profile)
- [ ] Recent activity (last 90 days = fresh signal)
- [ ] ELK/Elasticsearch mention = gold
- [ ] Tech stack mentions (Kafka, Logstash, Ansible, Kubernetes = good)
- [ ] Company pain signals from their posts

**Step 2c: Score and Prioritize**
```
Priority: High
  - Title matches exactly (VP Platform / Director SRE)
  - 1st or 2nd degree connection
  - Recent post or active engagement
  - ELK mention or platform pain signal

Priority: Medium
  - Title mostly matches
  - 2nd or 3rd degree
  - Some activity signal

Priority: Low
  - Title borderline (e.g., "VP Product" not platform)
  - 3rd+ degree
  - No recent activity
```

### Phase 3: Send Connection Requests

**Step 3a: Batch Send**
For all High and Medium priority prospects with Connect available:
```
connect_with_person(linkedin_username: "{username}")
```

**Step 3b: Track Blocked Profiles**
For follow-only profiles:
- Note in CRM as "Follow-Only"
- Don't retry more than once
- Move on

### Phase 4: Load into CRM

For each new prospect, add to the `vp_prospect` CRM object with:
- Full Name
- Title
- Company
- Company Size
- LinkedIn URL
- Connection Status: "Pending" / "Connected" / "Follow-Only" / "Not Connected"
- Priority: "High" / "Medium" / "Low"
- Pain Signals: From research (ELK mention, recent posts about platform pain, etc.)
- Last Activity: From LinkedIn profile ("3w ago", "Active today", etc.)

### Phase 5: Synthesize Findings

After research is complete, return a summary:
```json
{
  "vertical": "...",
  "companies_researched": ["Company A", "Company B"],
  "pain_themes": ["theme 1", "theme 2"],
  "prospects_added": [
    {"name": "...", "company": "...", "connection_status": "Pending"}
  ],
  "connection_requests_sent": N,
  "follow_only_profiles": [...],
  "top_3_recommendations": ["company or prospect 1", "..."]
}
```

## Vertical Shortcuts (Pre-Researched)
These verticals and companies have confirmed ELK pain:

| Vertical | Company | Why |
|----------|---------|-----|
| Gaming/Media | **Discord** | Trillions of messages, hitting Lucene limits, multi-cluster migration |
| Banking | **BBVA** | 150-node Elastic cluster, 20 years transaction data |
| Logistics | **TVH** | Warehouse robotics logs, platform team was bottleneck |
| Telecom | **Brazilian Telecom** | 5K hosts, AI incident analysis exploration |
| Cybersecurity | **Sophos** | Explicit ELK/Logstash/Kibana in daily use |
| Fintech | **Goldman Sachs** | 5 confirmed VP/Director prospects, ELK for compliance logging |
| Fintech | **Stripe** | Platform modernization at scale |
| E-commerce | **Wayfair** | Black Friday/Cyber Monday log spikes |

## What NOT to Do
- **Don't send notes with connection requests** — use blank requests, follow up after acceptance
- **Don't use web_search for deep research** — it's blocked on most sites
- **Don't over-research** — 5-10 well-chosen prospects > 50 random ones
- **Don't pursue 3rd+ degree profiles** — accept the follow-only limitation
- **Don't target ICs without team authority** — they can't buy or champion the product
- **Don't target competitors or job seekers** — filter these out early

## Tool Priority
1. **PinchTab** for company/vertical research (Elastic.co customers, engineering blogs, Reddit)
2. **LinkedIn MCP** for prospect search and connection requests
3. **DuckDB CRM** for storing and updating prospect records
4. **web_search** — only as a last resort; most sites block it
