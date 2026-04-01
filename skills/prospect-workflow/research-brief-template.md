# Research Brief Template — VP Prospect Research

Use this template when spawning sub-agents to research a specific industry vertical.

## Template Variables
Replace all `{BRACKETS}` with specific values for the vertical being researched.

## Sub-Agent Task Prompt

```
Load and follow the skill at `/Users/collinpfeifer/.openclaw-dench/workspace/skills/prospect-workflow/SKILL.md`.

## Your Mission
Research the **{VERTICAL_NAME}** vertical for ELK Stack adoption and platform engineering decision-makers.

## Context
- **Product:** AI ELK Engineer — autonomous agent that debugs ELK pipelines, investigates Kafka/Logstash issues, works with Ansible
- **Target Buyer:** VP of Platform / Director of SRE / Platform Team Lead at companies running self-managed ELK
- **Goal:** Find companies in this vertical with ELK pain, identify pain signals, name VP/Director prospects

## Target Companies (Start Here)
{list 5-10 specific company names relevant to this vertical}

## Research Steps (in order)
1. Use PinchTab to navigate to https://www.elastic.co/customers — read case studies for companies in this vertical
2. Search each company's engineering blog for ELK/observability pain (URL pattern: https://engineering.{company}.com or https://{company}.com/blog)
3. Use LinkedIn MCP search_people to find VP/Director/Team Lead prospects at target companies:
   - Keywords: "VP Director Platform Engineering SRE site:linkedin.com/in {CompanyName}"
4. Profile the top 5-10 prospects using get_person_profile
5. Score each prospect (High/Medium/Low) based on ICP fit
6. Send connection requests to all Connect-available prospects
7. Add all prospects to CRM

## Deliverable
Return a JSON object:
```json
{
  "vertical": "{VERTICAL_NAME}",
  "companies_researched": [
    {
      "name": "Company",
      "size": "employees",
      "self_managed_elk": true,
      "pain_signals": ["exact quote from source"],
      "decision_makers": [{"name": "...", "title": "...", "linkedin": "..."}],
      "priority": "High"
    }
  ],
  "prospects_found": [
    {
      "name": "Full Name",
      "title": "Exact title",
      "company": "Company",
      "linkedin_url": "https://linkedin.com/in/...",
      "connection_degree": "1st/2nd/3rd+",
      "connect_available": true,
      "recent_post": "topic or null",
      "elk_signal": true,
      "pain_signals_from_profile": [],
      "priority": "High/Medium/Low"
    }
  ],
  "connection_requests_sent": ["name1", "name2"],
  "top_pain_themes": ["theme 1", "theme 2"],
  "recommendation": "why this vertical is high/low priority for outreach"
}
```

## Important Notes
- Use PinchTab (not web_search) for all research — web search is blocked on most sites
- Don't include notes with connection requests — send blank requests
- 3rd+ degree = follow-only, skip those profiles
- Focus on companies with confirmed ELK/self-managed infrastructure pain
- 5-10 well-chosen prospects is better than 50 mediocre ones
```

## Example: Fintech Vertical

```json
{
  "VERTICAL_NAME": "Fintech & Financial Services",
  "target_companies": [
    "Goldman Sachs",
    "Stripe", 
    "Robinhood",
    "Coinbase",
    "Plaid",
    "Chime",
    "Brex",
    "Square/Block",
    "Checkout.com"
  ]
}
```
