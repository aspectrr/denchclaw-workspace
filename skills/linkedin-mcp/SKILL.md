# LinkedIn MCP Server

Learnings, patterns, and best practices for using the LinkedIn MCP server (linkedin-mcp).

---

## Overview

The LinkedIn MCP server provides direct access to LinkedIn profile data, connections, messaging, and search. This skill documents patterns for effective use.

**Server:** `linkedin-mcp`

---

## Available Tools

| Tool | Purpose | When to Use |
|-------|----------|--------------|
| `get_person_profile` | Get detailed profile information (name, title, company, posts) | Researching a specific prospect, verifying job details, understanding their content/posts |
| `search_people` | Search for LinkedIn profiles by keywords | Finding prospects, discovering VPs/Directors at target companies |
| `connect_with_person` | Send connection request (optional message) | Connecting with new prospects |
| `get_sidebar_profiles` | Get profile suggestions from someone's sidebar | Finding similar prospects (snowball outreach strategy) |
| `get_company_profile` | Get company details (size, industry, followers) | Researching company for ICP validation |
| `get_company_posts` | Get posts from a company page | Understanding company messaging, recent announcements |
| `get_inbox` | Get message inbox | Checking for replies, managing ongoing conversations |
| `get_conversation` | Get specific conversation details | Reviewing conversation history |
| `search_conversations` | Search conversations by keywords | Finding specific threads |
| `send_message` | Send message to connection | Following up after connection accepted |
| `close_session` | Close LinkedIn MCP session | Clean up when done |

---

## Common Workflows

### Workflow 1: Check Connection Status Before Messaging

**Pattern:** Always verify connection exists before attempting to send messages.

```python
# Step 1: Get profile to check connection status
get_person_profile(linkedin_username="thomasemark")

# Step 2: Check if "Message" button shows "Pending"
# If pending → cannot send messages, must wait for acceptance
# If message button available → can send messages

# Step 3: Only if connected, use send_message
send_message(profile_urn="...", message="...")
```

**Learning:** Connection requests with no message result in `status: "pending"` and `note_sent: false`. You cannot send messages until they accept.

### Workflow 2: Prospecting - Snowball Strategy

**Pattern:** Use sidebar recommendations to find similar prospects.

```python
# Step 1: Find a high-quality prospect
get_person_profile(linkedin_username="thomasemark")

# Step 2: Get sidebar profiles from that person
get_sidebar_profiles(linkedin_username="thomasemark")

# Step 3: Review and connect with relevant profiles
connect_with_person(linkedin_username="suggested_profile_1")
connect_with_person(linkedin_username="suggested_profile_2")
```

**Learning:** Sidebar profiles are similar (same company, industry, role). This is efficient for ICP targeting.

### Workflow 3: VP/Director Outreach Sequence

**Pattern:** Curiosity-first, 3-part message sequence after connection accepted.

```python
# Step 1: Wait for connection acceptance (check profile periodically)
get_person_profile(linkedin_username="thomasemark")

# Step 2: If message button available (not "Pending"), send 3-part sequence
send_message(profile_urn="...", message="Hi Thomas, I'm an ELK engineer at OmniSOC and noticed you're at Foresite. Curious what SIEM stack you're running day-to-day?")
send_message(profile_urn="...", message="I'm trying to learn from folks further up in industry about how different teams handle SIEMs, specifically on-prem setups and team sizing.")
send_message(profile_urn="...", message="Totally understand if you're busy, but if you're open to a quick chat, I'd love to hear about your stack and what's working (or not working) for your team.")
```

**Learning:** Split into multiple messages for better mobile readability. Curiosity tone, not sales.

---

## Tool-Specific Learnings

### get_person_profile

**Parameter:** `linkedin_username` (not `profileUrl`)

**Common error:** Using `profileUrl` parameter instead of `linkedin_username`.

**Returns:**
- Profile URL
- Main profile section (name, title, company, connections count)
- Activity section (posts, reposts, certifications)
- References (linked people, companies, posts)
- `profile_urn` (needed for messaging)

**Key learnings:**
- Look for `Message: Pending` in profile to check connection status
- `profile_urn` is required for `send_message`, not username
- Recent posts/reposts show current interests and hiring activity

### connect_with_person

**Parameters:** `linkedin_username`

**Returns:**
- `status`: "pending" (if request sent but not accepted)
- `note_sent`: whether a note was included (always false for blank requests)

**Key learnings:**
- Blank connection requests (no message) often get better acceptance rates
- Once status is "pending", cannot send another request
- Must wait for acceptance before messaging

### search_people

**Use case:** Finding prospects by company, title, or keywords.

**Limitations:**
- Search results may not include all relevant profiles
- Better to use specific profiles you've already found via other means

### send_message

**Parameter:** `profile_urn` (not username)

**Common error:** Using `linkedin_username` instead of `profile_urn`.

**Prerequisite:** Must already be connected (see Workflow 1).

**Key learnings:**
- Messages send immediately
- No confirmation that message was read
- Check inbox periodically for replies

### search_conversations

**Use case:** Finding existing conversations with specific people.

**Returns:**
- Conversation URL
- Message history with that person
- Timestamps of messages

**Key learnings:**
- Search by name to find if you've already talked to someone
- Shows full message history for context

---

## Timeout and Performance

**Default timeout:** 10-30 seconds depending on LinkedIn load.

**Timeout scenarios:**
- `get_person_profile`: 15-30s if profile has many posts/activity
- `send_message`: 5-10s typically
- `search_people`: 10-20s

**Recommendation:** Use `timeoutMs` parameter for long-running operations:
```python
get_person_profile(linkedin_username="thomasemark", timeoutMs=45000)  # 45 seconds
```

**Error recovery:** If timeout occurs, retry once. If it fails again, the server may be rate-limited or LinkedIn may be slow.

---

## Best Practices

### 1. Research Before Outreach

- Always check profile for hiring activity ("We're hiring" posts)
- Look for recent role changes (new position at target company)
- Verify company size matches ICP (51-500 employees)

### 2. Respect Connection Status

- Never try to message if profile shows "Message: Pending"
- Wait for connection acceptance before sending outreach sequence
- Check `get_person_profile` periodically to monitor acceptance

### 3. Use Sidebar Snowball

- After connecting with a high-quality prospect, get their sidebar profiles
- These are contextually relevant (same company, role, industry)
- More efficient than cold search

### 4. Split Messages for Mobile

- LinkedIn mobile shows messages in bubble format
- Shorter messages (1-2 sentences) read better
- Don't combine 3-part sequence into one long message

### 5. Track in CRM

- After connection, record:
  - Connection Status: Connected / Pending / Rejected
  - Connection Quality: Great Fit / Good Fit / OK Fit / Bad Fit / Not ICP
  - Feedback Notes: What they said, what they care about

### 6. Curiosity Over Sales

- Lead with "curious what X you're running" not "I'm selling Y"
- "I'm trying to learn" is genuine because Collin actually wants to learn
- Ask about stack, challenges, team size — let them share pain points

---

## Anti-Patterns (What to Avoid)

### ❌ Using profileUrl instead of linkedin_username

```python
# Wrong
get_person_profile(profileUrl="https://linkedin.com/in/thomasemark")

# Right
get_person_profile(linkedin_username="thomasemark")
```

### ❌ Messaging Before Connection

```python
# Wrong - this will fail
send_message(profile_urn="...", message="Hi Thomas...")

# Right - check first
profile = get_person_profile(linkedin_username="thomasemark")
if "Pending" not in profile.status:
    send_message(profile_urn=profile.profile_urn, message="...")
```

### ❌ Long Single Messages

```python
# Wrong - hard to read on mobile
send_message(profile_urn="...", message="Hi Thomas, I'm an ELK engineer at OmniSOC and noticed you're at Foresite. Curious what SIEM stack you're running day-to-day? I'm trying to learn from folks further up in industry about how different teams handle SIEMs, specifically on-prem setups and team sizing. Totally understand if you're busy, but if you're open to a quick chat, I'd love to hear about your stack and what's working (or not working) for your team.")

# Right - split into 3 parts
send_message(profile_urn="...", message="Hi Thomas, I'm an ELK engineer at OmniSOC and noticed you're at Foresite. Curious what SIEM stack you're running day-to-day?")
send_message(profile_urn="...", message="I'm trying to learn from folks further up in industry about how different teams handle SIEMs, specifically on-prem setups and team sizing.")
send_message(profile_urn="...", message="Totally understand if you're busy, but if you're open to a quick chat, I'd love to hear about your stack and what's working (or not working) for your team.")
```

### ❌ Sales-First Messaging

```python
# Wrong - sounds like a pitch
"I'm building an AI ELK engineer and wanted to tell you about..."

# Right - curiosity first
"I'm an ELK engineer at OmniSOC and noticed you're at Foresite. Curious what SIEM stack you're running day-to-day?"
```

---

## Common Error Messages

| Error | Meaning | Solution |
|--------|----------|-----------|
| `Missing required argument [linkedin_username]` | Used `profileUrl` parameter | Use `linkedin_username="username"` (no URL) |
| `Unexpected keyword argument [profileUrl]` | Used wrong parameter name | Use `linkedin_username` instead |
| `A connection request is already pending` | Tried to connect with same person again | Wait for acceptance or move on |
| `Referenced column not found` | SQL query error in CRM | Check column names with `DESCRIBE` first |
| `timeout` | Tool call took too long | Increase `timeoutMs` or retry |

---

## State Management

### Connection States

| State | Meaning | Action |
|--------|----------|---------|
| **Not Connected** | No connection request sent | Send connection request |
| **Pending** | Request sent, waiting for acceptance | Wait, check periodically |
| **Connected** | Request accepted | Can send messages |
| **Rejected** | Request declined | Move to next prospect |

### CRM States

| Field | Values | When to Update |
|-------|----------|----------------|
| Status | Not Connected / Connection Pending / Connected / Rejected | After each interaction |
| Pipeline Stage | Research / Outreach / Conversation / Qualified / Closed | Progress through sales cycle |
| Connection Quality | Unrated / Great Fit / Good Fit / OK Fit / Bad Fit / Not ICP | After conversation or profile review |
| Priority | High / Medium / Low | Based on ICP fit and urgency |

---

## Memory Updates

After each significant interaction, update memory:

1. **CRM:** Update `vp_prospect` entry with latest status
2. **Daily memory (`memory/YYYY-MM-DD.md`):** Log outreach attempts, responses, learnings
3. **MEMORY.md:** Update "LinkedIn Outreach" or "Lead Pipeline" sections with key insights

---

*Last updated: 2026-04-02*
