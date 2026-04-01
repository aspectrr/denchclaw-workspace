# SKILL.md — Prospect LinkedIn Research

Find, profile, and connect with VP/Director-level prospects on LinkedIn using the LinkedIn MCP server.

## When to Use
- Finding decision-makers at a specific company or industry
- Profiling a prospect before outreach
- Batch-sending connection requests
- Checking if a prospect has mutual connections

## Tools
- **LinkedIn MCP** (`linkedin-mcp`):
  - `search_people` — Search for prospects by keyword + company
  - `get_person_profile` — Full profile with activity feed
  - `connect_with_person` — Send connection request
  - `get_company_overview` — Company size, industry, description
  - `get_company_profile` — Employee count, growth signals

## Target Prospect Profile (ICP)
```
Title keywords (in priority order):
1. "VP of Platform Engineering" / "VP Platform Engineering"
2. "Director of Platform Engineering" / "Director SRE"
3. "Senior Director of Engineering" (if platform/infrastructure focus)
4. "VP of Infrastructure" / "VP of Engineering" (platform-heavy)
5. "Engineering Manager" (Platform / DevOps / SRE / Observability)

COMPANY SIZE (CRITICAL FILTER):
- Target: 50-500 employees (or team of 2-10 engineers managing ELK)
- Acceptable: 500-2000 employees
- AVOID: 2000+ employees (too many resources, too many tools)

ELK CRITICALITY:
- Target: ELK is mission-critical — the platform team exists primarily to keep ELK running
- AVOID: Large tech companies where ELK is one of many pain points (Discord, Goldman Sachs,
  Stripe, BBVA) — they have dedicated teams and Elastic consulting. Not our ICP.

NOT:
- Individual contributors without team lead / manager title
- Contractors, job seekers, "open to work"
- Competitors (Elastic, Splunk, CrowdStrike employees)
- IT services / consulting companies
- Companies where ELK is a side concern, not core infrastructure
```

## Search Strategy

### By Company
Use `search_people` with company name + title keywords:
```
Keywords: "VP Director Platform Engineering site:linkedin.com/in {CompanyName}"
```
Note: The `site:linkedin.com/in` filter often doesn't work with LinkedIn's search. Use the MCP's built-in `search_people` with just keywords instead:
```
Keywords: "VP Director Platform Engineering SRE"
```
Then filter results by company from the profile.

### By Title + Company Size
For companies 50-500 employees:
```
Keywords: "Director of Platform Engineering SRE"
```

### By ELK Signal (Highest Intent)
Prospects who explicitly mention ELK/Elasticsearch in their profile:
```
Keywords: "ELK Elasticsearch Logstash Kibana"
```
Note: This is rare — <5% of profiles. When found, it's a very strong signal.

### By Active Posting
Use `get_person_profile` and check the Activity section:
- Posted in last 30 days = "Fresh" prospect
- Posted 1-3 months ago = "Warm"
- No recent posts = "Cold" (lower priority)

## Profiling a Prospect
For each prospect, use `get_person_profile` to capture:

**Must have:**
- Full name
- Current title and company
- Connection degree (1st = gold, 2nd = good, 3rd+ = follow-only)
- Whether Connect button is available (not follow-only)

**Nice to have:**
- Recent posts and engagement
- Tech stack mentions (ELK, Kafka, Ansible, Kubernetes = perfect)
- Background/previous companies
- Mutual connections
- Whether they're actively hiring (job posts in activity = stretched team)

**Red flags (deprioritize):**
- "Open to work" in profile
- No team (individual contributor only)
- Employee at Elastic/Splunk/competitor
- IT services/consulting company
- Connection degree 3rd+ (can't connect, only follow)

## Connection Requests

### Always Use Blank Connection Requests
LinkedIn MCP `connect_with_person` sends a blank connection request by default. Do NOT include a note in the initial request — send the note as a follow-up message after they accept.

### Priority Order
1. Fresh prospects (posted within 30 days) with Connect button available
2. Warm prospects (posted 1-3 months) with Connect available
3. Prospects with explicit ELK/Elasticsearch mentions
4. 2nd connection prospects (easier to convert)

### Connection Statuses
Track in CRM:
- **Not Connected** — Can't connect (3rd+ degree or profile restriction)
- **Pending** — Connection request sent, awaiting acceptance
- **Connected** — They accepted, ready for outreach message

### Blocked Profiles (Follow-Only)
Some profiles only show "Follow" not "Connect." These are:
- 3rd+ degree connections
- Profiles with network restrictions
- Premium-only features

**What to do:** Note in CRM as "Follow-Only" and move on. Don't waste time retrying.

## Batch Workflow
1. `search_people` for the target company + title keywords → get list
2. For each promising prospect, `get_person_profile` → evaluate fit
3. `connect_with_person` for all Connect-available prospects
4. Update CRM with connection status, pain signals, and last activity

## Common Pitfalls
- **Don't send notes with connection requests** — LinkedIn treats them as InMail (requires premium). Send blank requests and follow up after acceptance.
- **Retry follow-only profiles** once — sometimes the button appears after a page refresh. But if it fails twice, accept it and move on.
- **LinkedIn MCP search doesn't filter by site:** Use keywords that include the company name explicitly to narrow results.
- **3rd+ degree = no connect button** — Accept this. Find mutual connections or use InMail (premium) instead.
- **Don't obsess over company size** — A 10,000-person company with a VP of Platform Engineering is just as good as a 200-person company. The pain is the signal.

## Output Format
```json
{
  "prospects_found": [
    {
      "name": "Full Name",
      "title": "Exact title",
      "company": "Company",
      "linkedin_url": "https://linkedin.com/in/...",
      "connection_degree": "2nd",
      "connect_available": true,
      "recent_post": "topic or null",
      "recent_post_date": "2mo ago",
      "elk_signal": true,
      "pain_signals_from_profile": ["tech mentions", "topics posted about"],
      "priority": "High",
      "connection_status": "Pending"
    }
  ],
  "connection_requests_sent": ["name1", "name2"],
  "follow_only_profiles": ["name3"],
  "recommended_next_steps": ["send follow-up to accepted connections", "search next company"]
}
```
