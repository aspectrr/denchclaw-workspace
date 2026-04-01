# SKILL.md — Prospect Company Research

Research target companies using PinchTab browser automation to find engineering pain signals, decision-maker context, and product-market fit evidence.

## When to Use
- Researching a specific industry vertical for ELK/platform engineering pain
- Vetting a company before adding prospects to the CRM
- Finding engineering blog posts, case studies, or job postings that reveal pain points
- Confirming a company runs self-managed ELK (not Elastic Cloud)

## Tools
- **PinchTab** (`pinchtab-mcp`): Full browser automation with `navigate`, `get_text`, `find`, `click`, `scroll`
- **LinkedIn MCP** (`linkedin-mcp`): `get_company_overview`, `get_company_profile`, `search_people` (for company size validation)

## Research Sources (Priority Order)

### 1. Elastic.co Customers (HIGHEST VALUE)
Elastic publishes detailed case studies with exact pain language, cluster sizes, and cost savings.
```
Navigate to: https://www.elastic.co/customers
```
Look for: TVH, BBVA, Brazilian Telecom, ID Logistics — all confirmed ELK customers with quantified pain.

For a specific company: `https://www.elastic.co/customers/{company-slug}`

**What to extract:**
- Cluster size / data volume
- Exact pain points in their own words
- Cost/savings metrics
- Decision-maker name and title (sometimes listed)
- Whether they're on-prem or cloud

### 2. Engineering Blogs (HIGH VALUE)
Companies like Discord, Stripe, Shopify publish detailed post-mortems and architecture posts.
```
Navigate to: https://{company}.com/blog or https://engineering.{company}.com
```
Use PinchTab `find` to search for keywords: "ELK", "Elasticsearch", "observability", "logging", "pipeline", "Kafka", "indexing"

**Discord's engineering blog** is particularly valuable — they have a post "How Discord Indexes Trillions of Messages" with detailed ELK pain:
- URL: `https://discord.com/blog/how-discord-indexes-trillions-of-messages`
- Pain signals: Redis queue failures, bulk indexing fault tolerance, hitting Lucene MAX_DOC limits (~2B docs), multi-cluster migrations

### 3. Reddit (MEDIUM VALUE — Noisy)
Best subreddits for ELK pain:
- `r/elasticsearch` — ELK-specific pain, certifications, configuration issues
- `r/devops` — Platform engineering pain, observability
- `r/sysadmin` — Infrastructure logging issues

Navigate to: `https://www.reddit.com/r/elasticsearch/search/?q=elk+stack+{keyword}&sort=new`

**Limitation:** Reddit search results are often dominated by certification exam posts and vendor discussion. Filter for technical pain posts. Posts older than 90 days are cold leads.

### 4. Job Postings (MEDIUM VALUE)
Look for job postings that reveal understaffing or pain:
```
Navigate to: https://www.linkedin.com/work/search?keywords=Senior+Platform+Engineer+ELK+{company}
```
Or search: `site:linkedin.com OR site:greenhouse.io OR site:lever.co "ELK" "Platform Engineer" "{company}"`

**Pain signals in job posts:**
- "Experience with ELK stack" (they're dealing with it)
- "On-call rotation" (they're stretched)
- "Debug production issues" frequency mentioned
- Hiring multiple platform engineers (growth/understaffing)

### 5. Glassdoor / Company Reviews (LOW-MEDIUM VALUE)
```
Navigate to: https://www.glassdoor.com/Reviews/{company}-reviews.htm
```
Search for: "ELK", "Elasticsearch", "logging", "on-call", "platform team"

## Research Checklist
For each company, capture:
- [ ] Company name and employee count
- [ ] Do they run self-managed ELK or Elastic Cloud? (self-managed = our target)
- [ ] Cluster size / data volume if mentioned
- [ ] Exact pain language in their own words
- [ ] Decision-maker name and LinkedIn profile if found
- [ ] Last activity / hiring signals
- [ ] Priority score: High / Medium / Low

## Common Pitfalls
- **Web search is blocked** on most sites — don't rely on `web_search` for deep research. Use PinchTab to navigate directly.
- **Reddit search is noisy** — cert exam posts dominate. Use company/engineering blog research instead.
- **LinkedIn search filters** (like `site:linkedin.com/in`) often don't work. Use LinkedIn MCP `search_people` with keywords instead.
- **Don't over-research** — the goal is enough signal to add a prospect and send a connection request. Deep dive on the most promising 2-3 companies per vertical.

## Output Format
Return findings as:
```json
{
  "companies_researched": [
    {
      "name": "...",
      "size": "...",
      "self_managed_elk": true,
      "pain_signals": ["exact quote from source"],
      "decision_makers": [{"name": "...", "title": "...", "linkedin": "..."}],
      "priority": "High",
      "source": "elastic.co/customers | engineering blog | reddit | job posting"
    }
  ],
  "top_pain_themes": ["theme 1", "theme 2"],
  "recommended_companies_for_outreach": ["company 1", "company 2"]
}
```
