# Bottom-Up Prospect Discovery Strategy

**Core Idea:** Find IC engineers doing ELK work → trace to their company → find their team leads.

Instead of guessing which companies run ELK, find the people who actually do the work. Their company is automatically qualified because someone there manages ELK daily.

---

## Step 1: Find ELK Engineers on LinkedIn

### Search Strings

**Primary search (job titles + ELK keywords):**
```
("SIEM Engineer" OR "Detection Engineer" OR "SOC Engineer" OR "Security Engineer" OR "Observability Engineer" OR "SRE" OR "Platform Engineer" OR "DevOps Engineer")
AND ("Elasticsearch" OR "ELK Stack" OR Kibana OR Logstash)
```

**Alternative search (security + ELK):**
```
("SIEM" OR "Detection Engineering" OR "Security Monitoring")
AND ("Elasticsearch" OR "ELK" OR Kibana)
```

**On-prem signal search:**
```
("Elastic" OR "ELK") AND ("on-prem" OR "on-premises" OR "data center" OR "self-hosted")
AND ("Security Engineer" OR "SIEM Engineer" OR "SOC Engineer")
```

### Job Titles to Target

**Security-focused (best hits):**
- Security Engineer
- Detection Engineer
- SOC Engineer
- Security Operations Engineer
- SIEM Engineer
- Threat Detection Engineer
- Blue Team Engineer
- Cybersecurity Engineer

**Observability / Logging / Data pipeline:**
- Observability Engineer
- Logging Engineer
- Monitoring Engineer
- Telemetry Engineer
- Data Engineer (if logs/streaming focused)

**Infrastructure / Platform:**
- Site Reliability Engineer (SRE)
- Platform Engineer
- DevOps Engineer
- Infrastructure Engineer

**Specialized / niche (often overlooked, gold):**
- Search Engineer (Elasticsearch-heavy)
- Elastic Engineer
- Log Analytics Engineer
- Detection & Response Engineer
- Security Data Engineer
- Cybersecurity Platform Engineer
- Cybersecurity Technical Specialist

### On-Prem Detection Signals

Look for these in profiles to confirm on-prem:
- "Data center" experience
- "Server management" or "Server administration"
- "On-prem" or "On-premises"
- "Self-hosted"
- "Purdue model" (OT/ICS)
- "OT/ICS security"
- "Hardware and virtualization"
- Ansible, Chef, Puppet (config management for on-prem)
- No mention of cloud-only tools

---

## Step 2: Find Similar People (Snowball Method)

Once you find a strong ELK engineer profile, use LinkedIn MCP to find similar people:

### Method 1: LinkedIn "Similar Profiles"
Use `get_sidebar_profiles` on a strong profile to find people LinkedIn recommends as similar.

### Method 2: Skills-Based Discovery
1. Open the engineer's profile
2. Find their "Elasticsearch" or "ELK Stack" skill
3. Click it → LinkedIn shows other people with that skill
4. These are often better matches than raw search

### Method 3: Company Teammates
1. Find a strong engineer at a company
2. Use `get_sidebar_profiles` to find teammates
3. Look for team leads / managers in the "People Also Viewed" section

### Method 4: Manager Discovery
1. Find an IC engineer
2. Check their activity for mentions of their manager
3. Look for job postings they share (mentions team structure)
4. Search `[engineer name]` + `manager` on LinkedIn

---

## Step 3: Qualify the Company

Once you find an ELK engineer, qualify their company using the checklist:

→ `/docs/company-qualification-checklist.md`

**Critical criteria:**
- [ ] MSP/MSSP or cybersecurity services
- [ ] ELK is their money maker
- [ ] On-prem deployment
- [ ] Data center/on-prem infrastructure
- [ ] Company size < 200

If company doesn't pass all criteria → still add engineer as a **peer connection** for learning conversations, but don't target their company as a customer.

---

## Step 4: Find the Team Lead

Once you have a qualified IC engineer:

1. **Check their LinkedIn activity** - reposts, comments may mention their manager
2. **Use `get_sidebar_profiles`** - often shows teammates including managers
3. **Search the company on LinkedIn** - filter by title: "Director", "VP", "Manager", "Sr. Manager"
4. **Look at job postings** the engineer shares - often mention team structure
5. **Check "People Also Viewed"** on the engineer's profile

### Team Lead Titles to Look For:
- Sr. Manager, Cybersecurity
- Director of Security Operations
- VP of Platform Engineering
- Director of SRE/Infrastructure
- SOC Manager
- Head of Security Engineering
- CISO (at smaller companies)

---

## Workflow: From Engineer to Customer

```
1. Search LinkedIn for ELK engineers
2. Find strong profile (does similar work to Collin)
3. Check their company → Run qualification checklist
4. If company passes → Find their team lead
5. Connect with both (engineer + team lead)
6. Learning conversation with engineer → Intro to team lead
7. Team lead has budget authority → Pitch
```

---

## Examples

### ✅ Bottom-Up Success Pattern
1. Found Aristotle Limjuco (Elastic SIEM engineer at Disneyland Resort)
2. Identified manager: Ryan O'Leary (Sr. Manager, Attraction OT Cybersecurity)
3. Added both to CRM (engineer + team lead)
4. Company is large (not ICP) but peer learning conversation is valuable

### 🔄 Ideal Flow (Finding ICP Company)
1. Search: "SIEM Engineer" AND "Elasticsearch"
2. Find engineer at small MSSP (< 200 employees)
3. Company passes qualification checklist
4. Find their VP/Director of Security
5. Connect with both
6. Engineer conversation validates pain
7. VP/Director has budget → close

---

**Last updated:** 2026-04-02
**Related:** `/docs/company-qualification-checklist.md`
