# Research Brief: ELK Engineer AI - Industry Prospect Research

## Decision
Which industry verticals offer the highest-leverage entry points for an "AI ELK Engineer" product (autonomous agent that debugs ELK pipelines, investigates Kafka/Logstash issues, works with Ansible)?

## Target Customer Profile
**ICP: VPs and Team Leads responsible for understaffed ELK/platform teams**
- VP of Platform / VP of Infrastructure / VP of Engineering
- Director of SRE / Director of Platform Engineering
- Platform Team Lead
- Engineering Manager (Platform/DevOps/Observability)
- Company size: 50–500 employees (small-medium, self-managed ELK)
- NOT: contractors, job seekers, IT services companies, competitors

## What We're Looking For (Per Industry)
1. **Companies** in this vertical that run self-managed ELK (not Elastic Cloud)
2. **Pain signals** — ELK/DevOps job postings, Reddit complaints, engineering blog posts
3. **Decision-maker names** — VP/Director/Lead level, specifically in platform/infrastructure/SRE
4. **Headcount signals** — Are they hiring platform engineers? Understaffed signals?
5. **Language** — How do they describe their ELK pain? (for outreach messaging)

## Research Sources
- r/elasticsearch, r/devops, r/sysadmin (pain signals)
- LinkedIn (decision-maker names + company size validation)
- Job postings (Indeed, LinkedIn, Greenhouse — search: "ELK" + "Platform Engineer" + industry)
- Company engineering blogs
- Stack Overflow / Stack Exchange (ELK questions)

## Deliverable Per Agent
```json
{
  "industry": "...",
  "top_10_companies": [
    {
      "name": "...",
      "size": "...",
      "why_elk_likely": "...",
      "pain_signals": ["..."],
      "notable_hires": "..."
    }
  ],
  "decision_makers_identified": [
    {
      "name": "...",
      "title": "...",
      "company": "...",
      "linkedin_url": "...",
      "source": "..."
    }
  ],
  "top_pain_language": ["..."],
  "priority_score": 1-10,
  "recommendation": "..."
}
```

## Industries to Research (8 agents)
1. Fintech & Financial Services
2. Healthcare & HealthTech
3. E-commerce & Retail Tech
4. Logistics & Supply Chain
5. Cybersecurity & MSSP
6. Manufacturing & Industrial IoT
7. Media & Streaming / Gaming
8. Telecom & Networking
