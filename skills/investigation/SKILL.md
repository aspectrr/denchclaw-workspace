# Investigation Skill

**Purpose:** Systematic approach to investigating feed/pipeline issues. This skill refines over time as the agent learns patterns in each customer's environment.

---

## Core Principle

Work backward from the symptom. Start at Elasticsearch and trace the data flow until you find the failure point.

```
Elasticsearch → Logstash → Kafka → Aggregator → Client Source
     ↑              ↑        ↑         ↑
   (most likely    (often    (check    (check
    to be fine)     DLQ)     lag)      last)
```

---

## Investigation Chain

### Step 1: Check Elasticsearch

**Questions to answer:**
- Is data coming in at all?
- Are documents indexed in the expected timeframe?
- Is the index healthy?

**Commands/APIs:**
- Kibana Dev Tools query for recent documents
- Check cluster health
- Verify index exists and has recent docs

**If data is there but old:** → Likely lag in pipeline (logstash overloaded)
**If no data:** → Continue to Step 2

---

### Step 2: Check Logstash

**Questions to answer:**
- Is Logstash running?
- Are there errors in logs?
- Is the DLQ growing?
- Are configs applied correctly?

**Commands/APIs:**
- `systemctl status logstash` (if accessible)
- Grep logs for ERROR, FATAL, exceptions
- Check DLQ directory/file count
- Check config files match expected state

**If DLQ growing:** → Parsing or transformation error
**If service down:** → Restart needed (human action)
**If logs show errors:** → Note error pattern, continue

---

### Step 3: Check Kafka

**Questions to answer:**
- Is the consumer group lag increasing?
- Is data in the topic at all?
- Is the broker healthy?

**Commands/APIs:**
- Kafka consumer group lag query
- List topics, describe topic
- Check broker health

**If no data in Kafka:** → Continue to Step 4
**If Kafka has data, Logstash not consuming:** → Logstash consumer issue

---

### Step 4: Check Aggregator (Logstash/Filebeat)

**Questions to answer:**
- Is the aggregator running?
- Are there errors in logs?
- Is it receiving data?
- Is the DLQ growing?

**Commands/APIs:**
- SSH into aggregator
- `systemctl status`
- Grep logs
- Check DLQ
- TCP dump if needed (human approval)

**If service needs restart:** → Flag for human
**If no errors but no data:** → Check network (TCP dump)

---

### Step 5: Check Client Source

**Questions to answer:**
- Is the client aggregator running?
- Is WireGuard tunnel up?
- Is the client sending data?

**Commands/APIs:**
- SSH into client bastion
- Check WireGuard status
- Check client logs

**If client not sending:** → Prepare escalation message

---

## Escalation Patterns

### Situation: Found the Problem

Format:
```
📋 Investigation Complete

**Problem:** [What you found]
**Location:** [Where]
**Evidence:** [Logs/errors/timestamps]

**Recommended Action:** [What should happen next]
**Assigned To:** [Who needs to act]
```

### Situation: Cannot Find Problem

Format:
```
🔍 Investigation Complete - No Issue Found

**What I Checked:**
- [x] Elasticsearch: [status]
- [x] Logstash: [status]
- [x] Kafka: [status]
- [x] Aggregator: [status]
- [x] Client: [status]

**Next Steps:**
1. [ ] Verify with human check
2. [ ] Consider reaching out to client
3. [ ] Monitor for new alerts

**Still Investigating:** [If continuing to monitor]
```

### Situation: Needs Human Action

Format:
```
⚠️ Human Action Required

**Issue:** [What needs to happen]
**Why:** [Why agent can't do it]
**Location:** [Where to do it]
**Steps:**
1. [ ] Step 1
2. [ ] Step 2

**Ready When:** [Any prerequisites]
```

---

## Evidence Collection

When investigating, always collect:

1. **Timestamps** - When did the issue start?
2. **Error messages** - Exact error text
3. **Log excerpts** - Relevant log lines
4. **Configuration state** - What configs are applied?
5. **Recent changes** - Any deployments before issue?

Store evidence in investigation notes for learning.

---

## Learning from Investigations

After each investigation:

1. **What was the root cause?** - Document it
2. **Where in the chain did it fail?** - Track patterns
3. **What would have caught it faster?** - Improve monitoring
4. **Any new patterns?** - Update this skill

Over time, the agent builds:
- Common error → root cause mappings
- Faster diagnosis paths
- Customer-specific patterns
- Preferred tools/commands per environment

---

## Notes per Environment

The agent should maintain notes for each customer environment:

```
Customer: [Name]
Last Updated: [Date]

Common Issues:
- [Pattern 1]
- [Pattern 2]

Preferred Commands:
- [Command 1]
- [Command 2]

Contact:
- Primary: [Name/handle]
- Escalation: [Name/handle]
```

These notes refine automatically as investigations happen.
