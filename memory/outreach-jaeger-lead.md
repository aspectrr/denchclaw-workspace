## Reddit Reply Template: Jaeger Collector Backend Lead

### Lead Details
- **URL:** https://www.reddit.com/r/elasticsearch/comments/1rq5kgv/
- **Posted:** March 9, 2026
- **Title:** "Elasticsearch as Jaeger Collector Backend Consuming rapid disk and it got restored after restarting elasticsearch service"
- **Pain Point:** Jaeger + ES causing rapid disk consumption, service restart "fixes" it
- **Priority:** High

---

### Public Comment (Reply to the Post)

```
Hey! I've seen this exact pattern before when using Elasticsearch as a Jaeger backend. A few things to check:

1. **Index lifecycle policies** — Jaeger creates daily indices (jaeger-span-YYYY-MM-DD, jaeger-service-YYYY-MM-DD, etc.). If you don't have ILM configured, these just accumulate forever. Check:
   ```
   GET _cat/indices/jaeger-*?v&s=index:desc
   ```
   If you see hundreds of old indices, that's your culprit.

2. **Jaeger retention settings** — Jaeger has its own ES_RETENTION env var, but it only works if you configure the rollover correctly. By default, it doesn't delete anything.

3. **Mapping explosions** — Jaeger spans can have high cardinality tags. If you're indexing raw HTTP paths or trace IDs as keywords, that index bloats fast. Check your field count:
   ```
   GET jaeger-span-*/_field_caps?fields=*
   ```
   
4. **The restart "fix"** — This suggests ES is holding onto segments or not flushing properly. Could be a memory pressure issue causing merges to stall.

What's your current retention setup? Are you using the Jaeger operator with rollover, or just letting it write to daily indices indefinitely?
```

---

### Follow-Up DM (If They Reply)

```
Hey! Saw your reply on the Jaeger + ES thread — disk consumption issues with tracing backends are painful to debug.

I'm an ELK engineer (been working with Elastic for 5+ years at a SOC-as-a-service company), and I've helped teams troubleshoot these exact Jaeger integration issues before.

The restart "fix" is a red flag — usually means there's a deeper indexing or retention issue that'll just come back.

If you're still dealing with this, I offer a short debugging session where I help troubleshoot the integration with you. I charge $500 for a 1-hour session with a simple guarantee: if we don't identify the issue or you don't find it valuable, you pay nothing.

No pressure either way — just wanted to offer since I know how annoying these "fixes itself on restart" issues can be!
```

---

### Why This Lead is High Priority

1. **Production impact** — Jaeger tracing + disk issues = potential data loss or service outage
2. **The "restart fix"** — Classic sign of a deeper problem that needs real debugging
3. **Complex integration** — Jaeger + ES is non-trivial, they likely need help
4. **9 comments** — Active thread, they're engaged and seeking solutions

---

### Key Technical Points to Reference

- Jaeger creates indices: `jaeger-span-*`, `jaeger-service-*`, `jaeger-dependencies-*`
- Default daily rollover without ILM = infinite growth
- High cardinality tags (trace IDs, URLs) = massive field explosion
- Restart "fixing" it = memory pressure or merge issues

---

### Tracking

After sending:
1. Update CRM Status to "Contacted"
2. Set reminder to check for reply in 48 hours
3. If no reply after 7 days, mark as "No Response"
