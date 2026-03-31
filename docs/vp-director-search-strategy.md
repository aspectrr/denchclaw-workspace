# VP/Director/Team Lead Search Strategy

**Created:** 2026-03-31
**Target Buyer:** Decision-makers with budget authority for understaffed ELK teams

---

## Target Persona

### Ideal Buyer Profile

| Attribute | Value |
|-----------|-------|
| **Titles** | VP of Platform, VP of Infrastructure, VP of Engineering (platform focus), Director of SRE, Director of Platform Engineering, Director of DevOps, Platform Team Lead, Senior Manager (logging/observability), Engineering Manager (ELK-focused) |
| **Company Size** | 50-500 employees (small-medium) |
| **Tech Stack** | Elasticsearch/ELK must be mission-critical |
| **Team Size** | 3-20 engineers managing ELK |
| **Budget Authority** | Yes (headcount budget) |
| **Pain** | Understaffed, drowning in requests, on-call burnout |

### NOT Good Fits

| Exclude | Why |
|---------|-----|
| Individual contributors | No budget authority |
| CTO/VP Engineering (too broad) | Not close enough to ELK pain |
| Job seekers / Open to work | Leaving, can't advocate |
| IT services/consulting companies | They provide ELK support to clients |
| Elastic/Splunk/Datadog employees | Competitors |
| Large enterprises (5000+) | Complex procurement, slow sales |

---

## LinkedIn Search Queries

### By Title + Elasticsearch

```
"VP of Platform" elasticsearch
"VP of Infrastructure" elasticsearch
"Director of SRE" elasticsearch
"Director of Platform" elasticsearch
"Platform Engineering Manager" elasticsearch
"Site Reliability Engineering Manager" elasticsearch
"Engineering Manager" "elasticsearch OR elk OR logging"
"Senior Manager" "observability OR logging"
"Team Lead" "platform engineering" elasticsearch
```

### By Title + Related Keywords

```
"VP of Platform" "site reliability" OR "reliability engineering"
"Director of SRE" "logstash" OR "kibana" OR "elastic"
"Platform Engineering Manager" "logging" OR "observability"
"Infrastructure Manager" "elk stack"
"DevOps Manager" "elasticsearch cluster"
```

### By Company Type (Elastic Users)

```
"VP of Platform" "elastic" OR "elasticsearch" site:linkedin.com/company/
"Director of SRE" "elastic cloud"
"Platform Team Lead" "logging architecture"
```

### By Pain Signal

Search for people who mention:
```
"on-call" "elasticsearch" "manager" OR "director"
"understaffed" "platform" OR "infrastructure"
"hiring" "elasticsearch engineer" manager
"team lead" "logging" OR "observability"
```

---

## Company Size Filters

### Target Company Sizes

| Size | Annual Revenue | Employees | Notes |
|------|-----------------|-----------|-------|
| Small | $10M-$50M | 50-100 | Fast decision, but limited budget |
| Medium | $50M-$200M | 100-500 | Sweet spot - budget + urgency |
| Large (avoid) | $500M+ | 500+ | Complex procurement |

### Company Indicators

Look for companies that:
- Have 3-20person engineering teams
- Are hiring for ELK/SRE roles (they're struggling)
- Post about logging/observability challenges
- Use Kubernetes (often use ELK for logs)
- Are in regulated industries (finance, healthcare, SaaS with compliance)

---

## Search Workflow

### Step 1: Run Title-Based Searches

Use LinkedIn MCP `search_people` with each query:

```bash
mcp call linkedin-mcp search_people \
  --params '{"keywords": "VP of Platform elasticsearch", "limit": 25}'
```

### Step 2: Filter by Company Size

For each result, check:
1. Company size (LinkedIn profile shows employee count)
2. Industry (exclude IT services, consulting)
3. Recent posts (look for ELK-related content)

### Step 3: Enrich with Sidebar Recommendations

For high-quality connections, use `get_sidebar_profiles` to find similar prospects:

```bash
mcp call linkedin-mcp get_sidebar_profiles \
  --params '{"linkedin_username": "john-doe-12345"}'
```

This finds "People also viewed" — often similar VPs/Directors.

### Step 4: Add to CRM

Create entries with:
- **Object:** `vp_prospect` (new object)
- **Fields:** Name, Title, Company, Company Size, LinkedIn URL, Status, Priority, Notes

---

## Outreach Messaging

### Connection Request (Blank)

**DoNOT include a message.** Blank connection requests have higher acceptance rates for VPs/Directors.

### Follow-up Message (After Connection Accepted)

**Subject:** Quick question about your ELK stack

> Hi [First name],
> 
> I noticed you're leading [platform/infrastructure/SRE] at [Company]. I've been talking with ELK teams who are dealing with [specific pain - on-call burnout / understaffed / drowning in requests].
> 
> My team is exploring building an AI ELK engineer that can handle 50% of the routine debugging and pipeline work. Would love to hear your perspective - what's the biggest time sink for your team right now?
> 
> No pitch, just research. Happy to share what I'm learning from other teams.

### Alternative: Infra Audit Offer

> Hi [First name],
> 
> I'm working on an AI tool for ELK engineers and looking to understand the real pain points teams face. Would you be open to a 30-min infrastructure audit? I'll review your ELK setup and share 3-5 specific improvements - free, no strings.
> 
> I've worked with teams dealing with [shard issues / cluster instability / Logstash pipeline problems] and always learn something new.

---

## Prioritization Framework

### High Priority (>90 days active)

| Signal | Why |
|--------|-----|
| Recently posted about ELK issues | Active pain, current context |
| Company hiring for ELK/SRE roles | Understaffed, need help |
| Post mentions "on-call" or "burnout" | Feels the pain directly |
| Small team (5-15 engineers) | Decision likely faster |

### Medium Priority (60-90 days)

| Signal | Why |
|--------|-----|
| Active in ELK communities | Knowledgeable, potential advocate |
| Company using Kubernetes + ELK | Modern stack, likely mission-critical |
| Posted about logging/observability | Has context, may have pain |

### Low Priority (>90 days)

| Signal | Why |
|--------|-----|
| No recent ELK activity | May not be current pain |
| Large enterprise (>1000 employees) | Complex procurement, long sales cycle |
| Consulting/systems integrator | Not end customer |

---

## CRM Object: `vp_prospect`

Create a new object to track VP/Director prospects separately from IC leads:

```sql
-- Create vp_prospect object
INSERT INTO objects (name, description, default_view)
VALUES ('vp_prospect', 'VP/Director/Team Lead prospects with budget authority', 'table');

-- Create fields
INSERT INTO fields (object_id, name, type, sort_order) VALUES
((SELECT id FROM objects WHERE name = 'vp_prospect'), 'Full Name', 'text', 1),
((SELECT id FROM objects WHERE name = 'vp_prospect'), 'Title', 'text', 2),
((SELECT id FROM objects WHERE name = 'vp_prospect'), 'Company', 'text', 3),
((SELECT id FROM objects WHERE name = 'vp_prospect'), 'Company Size', 'enum', 4),
((SELECT id FROM objects WHERE name = 'vp_prospect'), 'LinkedIn URL', 'url', 5),
((SELECT id FROM objects WHERE name = 'vp_prospect'), 'Status', 'enum', 6),
((SELECT id FROM objects WHERE name = 'vp_prospect'), 'Priority', 'enum', 7),
((SELECT id FROM objects WHERE name = 'vp_prospect'), 'Last Activity', 'date', 8),
((SELECT id FROM objects WHERE name = 'vp_prospect'), 'Notes', 'richtext', 9),
((SELECT id FROM objects WHERE name = 'vp_prospect'), 'Pain Signals', 'tags', 10);

-- Set enum values
UPDATE fields SET enum_values = '["1-50", "51-200", "201-500", "501-1000", "1000+"]' WHERE name = 'Company Size' AND object_id = (SELECT id FROM objects WHERE name = 'vp_prospect');
UPDATE fields SET enum_values = '["Not Connected", "Pending", "Connected", "Replied", "In Conversation", "Not Interested", "Converted"]' WHERE name = 'Status' AND object_id = (SELECT id FROM objects WHERE name = 'vp_prospect');
UPDATE fields SET enum_values = '["High", "Medium", "Low"]' WHERE name = 'Priority' AND object_id = (SELECT id FROM objects WHERE name = 'vp_prospect');
```

---

## Status Pipeline

| Status | Meaning | Next Action |
|--------|---------|-------------|
| Not Connected | Found but not yet reached | Send connection request |
| Pending | Connection request sent | Wait 7 days |
| Connected | Connection accepted | Send follow-up message |
| Replied | They responded | Continue conversation |
| In Conversation | Active dialogue | Qualify, offer audit |
| Not Interested | Declined | Archive, revisit in 6 months |
| Converted | Interested in paid session/audit | Schedule session |

---

## Success Metrics

| Metric | Target (Week 1) | Target (Month 1) |
|--------|-----------------|------------------|
| VP/Director leads identified | 50 | 200 |
| Connection requests sent | 20 | 100 |
| Connections accepted | 10(50%) | 50 (50%) |
| Follow-up messages sent | 10 | 50 |
| Replies received | 3(30%) | 15 (30%) |
| Conversations initiated | 2 | 10 |
| Paid sessions booked | 1 | 5 |

---

## Integration with Existing Workflow

### Daily Cron Job

Extend the existing LinkedIn cron job to also run VP/Director searches:

```yaml
# In addition to IC searches, run VP searches at different times
- 10:00 AM: VP of Platform / VP of Infrastructure searches
- 2:00 PM: Director of SRE / Platform Engineering searches  
- 4:00 PM: Team Lead / Engineering Manager searches
```

### Handoff to Collin

When a VP/Director replies:
1. Update CRM status to "Replied"
2. Add detailed notes about their context
3. Collin takes over the conversation
4. After conversation, Collin updates Connection Quality field

---

## Next Steps

1. **Create `vp_prospect` object** in DuckDB
2. **Run first batch of searches** using LinkedIn MCP
3. **Set up cron job** for daily VP searches
4. **Track results** in CRM
5. **Iterate on messaging** based on response rates

---

*Created: 2026-03-31*
*Related: elk-engineer-market-strategy.md, linkedin-profile-finder-workflow.md*