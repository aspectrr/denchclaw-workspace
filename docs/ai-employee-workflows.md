# AI ELK Engineer Workflows

**Purpose:** Define the day-to-day workflows an AI employee would handle, based on actual ELK engineering work.

---

## Workflow 1: Feed Down Investigation

**Trigger:** Alert from Python monitoring script (timestamp lag exceeds threshold)
**Priority:** HIGH (on-call issue)
**Owner:** On-call engineer → AI employee

### Investigation Chain

```
ALERT: Feed [name] down - last timestamp older than [threshold]
       ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 1: Elasticsearch/Kibana Check                          │
│ - Query cluster for feed index                              │
│ - Check if documents coming in within expected timeframe    │
│ - If YES: Feed is just lagging (logstash overload?)         │
│ - If NO: Continue investigation                             │
└─────────────────────────────────────────────────────────────┘
       ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 2: Logstash Check                                      │
│ - Check DLQ (Dead Letter Queue) for errors                  │
│ - Search logs for config errors, parse failures            │
│ - If errors found: Diagnose, propose fix                   │
│ - If clean: Continue investigation                          │
└─────────────────────────────────────────────────────────────┘
       ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 3: Network/Kafka Check                                 │
│ - TCP dump: Is data arriving from Kafka?                    │
│ - Check Kafka consumer lag for topic                       │
│ - Check Kafka broker status                                 │
│ - Check Logstash status                                     │
│ - If Kafka empty: Continue investigation                    │
│ - If Kafka has data: Logstash/consumer issue               │
└─────────────────────────────────────────────────────────────┘
       ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 4: Aggregator Check                                    │
│ - SSH into aggregator (logstash/filebeat)                   │
│ - Check DLQ on aggregator                                   │
│ - Check logs for config issues                              │
│ - Check if service running                                  │
│ - TCP dump: Is aggregator receiving data?                   │
│ - If needs restart: Restart service                         │
│ - If no data arriving: Continue investigation               │
└─────────────────────────────────────────────────────────────┘
       ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 5: Client Escalation                                   │
│ - If nothing in aggregator: Client data source is down     │
│ - Escalate to client contact                               │
│ - Provide investigation summary                            │
└─────────────────────────────────────────────────────────────┘
```

### What AI Employee Can Do Autonomously

| Step | Capability | Safe? |
|------|-----------|-------|
| Check ES/Kibana for data | Query cluster, check timestamps | ✅ Safe |
| Check Logstash logs/DLQ | Read logs, identify errors | ✅ Safe |
| Check Kafka lag/status | Query Kafka, check consumer groups | ✅ Safe |
| Check aggregator logs | SSH + grep logs | ✅ Safe |
| TCP dump analysis | Run tcpdump, analyze output | ⚠️ Requires approval |
| Restart services | systemctl restart | ⚠️ Requires approval |
| Escalate to client | Send message/email | ✅ Safe with template |

### What Needs Human Approval

- Restarting any service
- Running network diagnostics (tcpdump)
- Making config changes
- Contacting clients (approval + template)

---

## Workflow 2: New Pipeline Development

**Trigger:** Request from security engineers for new data feed
**Priority:** Medium
**Owner:** Pipeline engineer → AI employee

### Development Process

```
REQUEST: New pipeline for [feed name] from [client]
         ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 1: Gather Requirements                                 │
│ - What data source? (Kafka topic, filebeat, etc.)          │
│ - What fields need to be extracted?                        │
│ - What enrichment needed? (geoip, etc.)                    │
│ - Which cluster? (dev, prod)                               │
│ - Any special transformations?                             │
└─────────────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 2: Check if Pipeline Template Exists                  │
│ - Search GitHub repo for similar pipelines                  │
│ - If exists: Apply base config via Ansible                │
│ - If not: Build from scratch                              │
└─────────────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 3: Deploy to Development Logstash                     │
│ - Run Ansible playbook to deploy config                    │
│ - Apply metafilters, Kafka input, ES output               │
│ - Start with basic config, iterate                         │
└─────────────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 4: Iterate on Config                                  │
│ - Send test data through                                  │
│ - Check ES for output                                      │
│ - Identify parsing issues                                  │
│ - Adjust grok patterns, mappings                           │
│ - Repeat until clean                                      │
└─────────────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 5: Security Engineer Review                           ││
│ - Submit for approval                                     │
│ - Wait for security engineers to verify:                  │
│   - Correct data mapping                                  │
│   - Field values as expected                              │
│   - Monitoring rules can be created                      │
│ - Address feedback                                        │
└─────────────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 6: Deploy to Production                              │
│ - Runprod Ansible playbook                                 │
│ - Verify data flowing                                      │
│ - Hand off to security engineers                          │
└─────────────────────────────────────────────────────────────┘
```

### What AI Employee Can Do Autonomously

| Step | Capability | Safe? |
|------|-----------|-------|
| Gather requirements | Ask questions, document | ✅ Safe |
| Search for similar pipelines | GitHub search, grep | ✅ Safe |
| Generate pipeline config | Create logstash config | ⚠️ Reviewrequired |
| Deploy to devlogstash | Run Ansible playbook | ⚠️ Review required |
| Check ES output | Query, verify data | ✅ Safe |
| Identify parsing issues | Analyze, propose fix | ✅ Safe |
| Submit for approval | Notify engineers | ✅ Safe |

---

## Workflow 3: Parsing Issue Debugging

**Trigger:** Report from security engineers (field not mapping correctly)
**Priority:** Medium-High
**Owner:** Pipeline engineer → AI employee

### Debug Process

```
REPORT: Field [name] not parsing correctly in [feed]
        ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 1: Identify the Issue                                 │
│ - Check ES for examples of malformed data                  │
│ - Identify pattern: Is field missing? Wrong format?       │
│ - Check original data format in source                     │
└─────────────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 2: Locate Config File                                 │
│ - Find logstash config for feed                            │
│ - Identify grok pattern / filter responsible               │
│ - Check if metafilter needs update                         │
└─────────────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 3: Propose Fix                                        │
│ - Update grok pattern                                      │
│ - Add new field mapping                                    │
│ - Add conditional logic                                    │
│ - Test in dev environment                                 │
└─────────────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 4: Verify and Deploy                                  │
│ - Verify fix in dev ES                                     │
│ - Get approval from security engineers                    │
│ - Deploy to production                                    │
│ - Monitor for regressions                                 │
└─────────────────────────────────────────────────────────────┘
```

---

## Workflow 4: Data Source Investigation

**Trigger:** Need to understand client's Kafka topic structure
**Priority:** Low-Medium
**Owner:** Pipeline engineer → AI employee

### Investigation Process

```
REQUEST: Need data from [client]'s Kafka
         ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 1: Access Client Infrastructure                        │
│ - SSH into bastion (leap or skip)                          │
│ - Connect to client Kafka                                  │
│ - List topics                                              │
│ - Identify relevant topic                                  │
└─────────────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 2: Analyze Topic Structure                            │
│ - Check topic config (partitions, replication)            │
│ - Sample messages                                          │
│ - Identify message format (JSON, syslog, etc.)            │
│ - Document field structure                                 │
└─────────────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 3: Design Pipeline                                    │
│ - Create Kafka input config                                │
│ - Design grok patterns for message format                  │
│ - Plan enrichment (geoip, etc.)                           │
│ - Document for handoff to pipeline dev workflow           │
└─────────────────────────────────────────────────────────────┘
```

---

## Workflow 5: Cluster Infrastructure Setup

**Trigger:** New cluster needed or adding nodes
**Priority:** Low (rare but high impact)
**Owner:** Infrastructure engineer → AI employee (assist only)

**Note:** This is typically one-off work, not regular workflow. AI assists but doesn'town.

### Setup Process

```
REQUEST: New cluster / Add nodes
         ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 1: Provision Infrastructure                            │
│ - Use Foreman or MAAS to provision VM/LXD container        │
│ - Configure networking                                     │
│ - SSH into new host                                        │
└─────────────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 2: Configure Cluster Role                             │
│ - Install Elasticsearch/OpenSearch                         │
│ - Configure node role (master, data, coordinating)        │
│ - Set up TLS/authentication                               │
│ - Configure heap, memory, storage                         │
└─────────────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 3: Join Cluster                                       │
│ - Configure discovery                                      │
│ - Join existing cluster or bootstrap new                  │
│ - Verify cluster health                                   │
└─────────────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 4: Set Up Data Flow                                   │
│ - Configure Logstash pipeline to send to cluster          │
│ - Set up index templates                                   │
│ - Configure Kibana                                         │
│ - Verify data flowing                                      │
└─────────────────────────────────────────────────────────────┘
```

---

## Workflow 6: Metrics & Reporting

**Trigger:** Scheduled or ad-hoc reporting needs
**Priority:** Low
**Owner:** AI employee (autonomous)

### Metrics Tracked

| Metric | Purpose | Frequency |
|--------|---------|-----------|
| Volume per member | Team capacity planning | Weekly |
| Escalations per member | Workload distribution | Weekly |
| Feed downtime | SLA tracking | Per incident |
| Time to resolve | Performance tracking | Per incident |

### Reporting Process

```
SCHEDULE: Weekly metrics report
           ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 1: Collect Data                                        │
│ - Query ES for volume metrics                               │
│ - Pull incident data from ticketing system                  │
│ - Calculate per-member stats                               │
└─────────────────────────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 2: Generate Report                                     │
│ - Format as markdown/table                                 │
│ - Highlight anomalies (spikes, trends)                     │
│ - Include recommendations                                  │
└─────────────────────────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 3: Distribute                                          │- Post to Slack channel                                    │
│ - Update dashboard (if applicable)                         │
│ - Archive for historical tracking                          │
└─────────────────────────────────────────────────────────────┘
```

---

## Workflow 7: Enrichment Updates

**Trigger:** Need to update geoip or external data enrichment
**Priority:** Medium
**Owner:** Pipeline engineer → AI employee

### Process

```
REQUEST: Update enrichment database (MMDB, custom DB)
         ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 1: Download/Generate New Data                         │
│ - Pull latest MaxMind data                                 │
│ - Process custom enrichment tables                         │
│ - Generate MMDB if custom                                  │
└─────────────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 2: Deploy to Aggregators                              │
│ - Copy MMDB to logstash nodes                              │
│ - Reload or restart logstash                              │
│ - Test with sample data                                   │
└─────────────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 3: Verify Enrichment                                  │
│ - Query ES for enriched fields                            │
│ - Validate geoip data                                     │
│ - Check custom enrichment fields                          │
└─────────────────────────────────────────────────────────────┘
```

---

## Operating Model

### Core Principle: React → Investigate → Escalate if Needed

**Trigger Points:**
- Mentioned in Slack
- Mentioned in ClickUp
- Alert fired

**Default Behavior:**
- Act autonomously
- If it runs into an issue → ask before proceeding
- If it needs to make a change → prepare but human executes

### Hard Rule: Server Changes Are Human-Only

> ⚠️ **Any change on any server must be done by a human.**
> This is non-negotiable given the sensitivity of the environments.

The agent can:
- ✅ Investigate
- ✅ Query systems
- ✅ Analyze logs
- ✅ Prepare configs
- ✅ Propose solutions
- ✅ Draft messages

The agent cannot (without human):
- ❌ Run Ansible playbooks
- ❌ Restart services
- ❌ Modify configs on servers
- ❌ Deploy anything
- ❌ Make network changes

---

## Summary: What Can AI Employee Do?

### High Autonomy (Do Without Asking)

1. **Query & Analyze** - ES queries, log analysis, Kafka checks
2. **Investigate** - Walk through investigation chain, gather evidence
3. **Document** - Create runbooks, update docs
4. **Report** - Generate metrics reports
5. **Monitor** - Track feed status, alert on anomalies
6. **Prepare Changes** - Generate config diffs, PRs for review
7. **Draft Communications** - Write escalation messages, status updates

### Escalate Before Acting

1. **Server Changes** - Any Ansible, service restart, config modification
2. **Client Contact** - Any external communication
3. **Ambiguous Decisions** - When it's unclear what to do next
4. **New Patterns** - When it finds something it hasn't seen before

### Human-Owns

1. **All Server Changes** - Always human, always
2. **Cluster Infrastructure** - Provision VMs, configure hardware
3. **Security Decisions** - Access control, permissions
4. **Architecture Changes** - Major pipeline redesigns

---

## Technical Requirements

### Agent Workspace
- **VPS** with GitHub access (clones, PRs, reads)
- **Linux environment** for running investigation commands
- **Network access** to all systems in the chain

### Integrations
- **Slack** - React to mentions, post updates, ask questions
- **ClickUp** - React to mentions, update tasks
- **GitHub** - Clone repos, create PRs, read configs
- **Slack/Email** - Client escalation (with templates)

### Access Requirements
| System | Access | Purpose |
|--------|--------|---------|
| Elasticsearch | Query | Data verification |
| Kafka | Query | Consumer lag, topic inspection |
| Logstash | SSH + Logs | Pipeline debugging |
| Aggregators | SSH + Logs | Client-side debugging |
| GitHub | Clone + PR | Config management |
| Client Bastions | SSH | Data source investigation |

---

## How the Agent Learns

### Per-Environment Learning

The agent maintains notes for each customer environment that refine over time:

```
Customer: [Name]

Common Issues:
- [Pattern 1] → [Root cause]
- [Pattern 2] → [Root cause]

Preferred Commands:
- [Command shortcuts that work in this env]

Contact:
- Primary: [Slack handle]
- Escalation: [Name]
```

### From Investigations

After each investigation:
1. What was the root cause?
2. Where in the chain did it fail?
3. What would have caught it faster?
4. Any new patterns?

### Config Templates

The agent develops its own config templates based on:
- What works in each environment
- Best practices learned from successful pipelines
- Patterns from similar feed types

These are kept in the agent's workspace, not imposed.

---

## Next Steps

1. ✅ **Defined escalation paths** - Human owns server changes
2. **Client escalation templates** - Simple template, agent refines
3. **Set up Slack integration** - React to mentions
4. **Set up ClickUp integration** - React to task mentions
5. **Define customer environment setup** - Initial knowledge load