# LinkedIn Profile Finder Workflow

## Overview

This workflow helps you find LinkedIn profiles for Reddit leads so you can do multi-channel outreach (Reddit + LinkedIn).

**Key Challenge:** Reddit usernames rarely match LinkedIn directly. Most people use different usernames on different platforms.

**Solution:** Extract post IDs → Get Reddit usernames via MCP → Search LinkedIn using context clues (GitHub, bio links, or topic-based search).

---

## Files Created

1. **`scripts/find_linkedin_profiles.py`** - Main script for finding LinkedIn profiles
2. **`tmp/reddit_leads_2026-03-30.json`** - Today's Reddit leads (10 leads)
3. **`tmp/linkedin_prospects_2026-03-30.json`** - Generated search queries for each lead

---

## Usage

### Step 1: Extract Reddit Leads

First, search for Reddit leads using the Reddit MCP:

```bash
# Search r/elasticsearch for recent posts
mcp call reddit-mcp reddit_search_subreddit \
  --params '{"subreddit": "elasticsearch", "query": "error issue help", "limit": 20}'
```

### Step 2: Save Leads to JSON

Create a JSON file with the leads you want to find LinkedIn profiles for:

```json
[
  {
    "title": "Post title here",
    "url": "https://www.reddit.com/r/elasticsearch/comments/xxxxx/...",
    "description": "Brief description of their pain point",
    "priority": "High"
  }
]
```

### Step 3: Run the Profile Finder Script

```bash
python3 scripts/find_linkedin_profiles.py \
  --batch-file tmp/your_leads.json \
  --output tmp/linkedin_prospects.json
```

### Step 4: Get Reddit Usernames (Manual Step)

The script extracts post IDs but Reddit MCP needs to be called to get the actual username. For each lead:

```bash
# Use the Reddit MCP to get post details
mcp call reddit-mcp reddit_get_post \
  --params '{"permalink": "r/elasticsearch/comments/1rji2do/..."}'
```

Look for the `author` field in the response.

### Step 5: Search LinkedIn

Once you have the Reddit username, search LinkedIn using the generated queries:

**Option A: Web Search (DuckDuckGo)**
```
site:linkedin.com/in/ "username" elasticsearch elk devops
```

**Option B: LinkedIn MCP Direct Search**
```bash
mcp call linkedin-mcp search_people \
  --params '{"keywords": "elasticsearch engineer splunk migration"}'
```

**Option C: Search by Topic (Recommended)**
Since Reddit usernames rarely match LinkedIn, search by topic instead:
- Look for people posting about similar ELK issues
- Search for engineers at companies that use Elastic
- Use the pain point keywords from the Reddit post

---

## Alternative Approach: GitHub Bridge

Many Reddit users link their GitHub profiles, and GitHub profiles often have LinkedIn links.

1. Check if Reddit user has GitHub link in bio
2. Search for their GitHub profile:
   ```
   site:github.com "reddit_username"
   ```
3. Check their GitHub profile for LinkedIn URL

---

## Recommended Workflow for Future Agents

### When processing Reddit leads:

1. **Always try to get the Reddit username** using `reddit_get_post` MCP tool
2. **Check their Reddit profile** for GitHub/LinkedIn links in bio
3. **If no direct link found:**
   - Search LinkedIn by topic (e.g., "elasticsearch migration engineer")
   - Look for people at similar companies/industries
   - Use the pain point as a conversation starter
4. **Document findings** in the CRM with both Reddit and LinkedIn URLs

### Priority Order for Outreach:

1. **Reddit DM first** (they posted there, context is fresh)
2. **LinkedIn connection request** (with personalized note referencing their Reddit post)
3. **Follow-up on Reddit** if LinkedIn doesn't work

---

## LinkedIn Search Strategies

### By Pain Point Keywords

| Reddit Post Topic | LinkedIn Search Keywords |
|-------------------|-------------------------|
| Splunk migration | "splunk" "elasticsearch" "migration" "data engineer" |
| Logstash issues | "logstash" "data pipeline" "elk" "devops" |
| K8s/Helm setup | "kubernetes" "elasticsearch" "platform engineer" |
| Security/SOC | "soc analyst" "elasticsearch" "siem" "security engineer" |
| Data loss | "elasticsearch" "site reliability" "data integrity" |

### By Company Type

Search for engineers at:
- SOC-as-a-service companies
- Companies hiring for ELK roles (they're struggling!)
- Financial services (trading platforms use Elastic)
- E-commerce (search + analytics)

---

## CRM Integration

Add these fields to your `lead` object for tracking:

```sql
-- Add to your lead object
ALTER TABLE fields ADD COLUMN reddit_username TEXT;
ALTER TABLE fields ADD COLUMN linkedin_url TEXT;
ALTER TABLE fields ADD COLUMN github_url TEXT;
ALTER TABLE fields ADD COLUMN outreach_channel TEXT; -- 'reddit', 'linkedin', 'both'
```

---

## Example: Complete Workflow

```bash
# 1. Find Reddit leads
mcp call reddit-mcp reddit_search_subreddit \
  --params '{"subreddit": "elasticsearch", "query": "migration error", "limit": 10}'

# 2. Get usernames for promising leads
mcp call reddit-mcp reddit_get_post \
  --params '{"permalink": "r/elasticsearch/comments/1rji2do/..."}'
# Extract: author = "techmigrator42"

# 3. Search for their GitHub
curl "https://api.github.com/search/users?q=techmigrator42"

# 4. Check GitHub profile for LinkedIn
curl "https://api.github.com/users/techmigrator42"
# Bio: "Data engineer | LinkedIn: linkedin.com/in/sarah-chen-data"

# 5. Add to CRM
duckdb workspace.duckdb -c "
  INSERT INTO entry_fields (entry_id, field_id, value) VALUES
  ('lead-001', (SELECT id FROM fields WHERE name = 'LinkedIn URL'), 'linkedin.com/in/sarah-chen-data'),
  ('lead-001', (SELECT id FROM fields WHERE name = 'Reddit Username'), 'techmigrator42');
"
```

---

## Tools Summary

| Tool | Purpose | Command |
|------|---------|---------|
| Reddit MCP | Get post details, extract author | `mcp call reddit-mcp reddit_get_post` |
| LinkedIn MCP | Search for people | `mcp call linkedin-mcp search_people` |
| Web Search | Find GitHub/profiles | `web_search` tool |
| Profile Finder Script | Batch processing | `python3 scripts/find_linkedin_profiles.py` |

---

## Current Status (2026-03-30)

**Leads processed:** 10 Reddit posts
**LinkedIn profiles found:** 0 (usernames not yet extracted)
**Next step:** Call `reddit_get_post` for each lead to get author usernames

**Priority leads for username extraction:**
1. `1rji2do` - TB Splunk migration (High priority)
2. `1qajdeu` - 35k documents lost (Critical)
3. `1jh5h5c` - Log loss in Logstash (High)
4. `1ixsx22` - K8s Fleet Server (High)
5. `1iroejw` - Fleet Server enrollment (High)

---

## Notes for Future Agents

1. **Reddit API limitations:** `reddit_get_post` may return errors if Reddit is rate-limiting
2. **LinkedIn search limits:** LinkedIn MCP has monthly search limits (you hit this today)
3. **Privacy:** Not all Reddit users want to be found on LinkedIn - respect their privacy
4. **Alternative:** Sometimes it's better to engage on Reddit first, then ask for LinkedIn in the conversation

---

*Created: 2026-03-30*
*Script location: `scripts/find_linkedin_profiles.py`*
