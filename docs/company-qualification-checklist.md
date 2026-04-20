# Company Qualification Checklist

**Purpose:** Use this checklist every time when verifying a company as a prospect for the AI ELK Engineer tool.

## Critical Criteria (Must Pass ALL)

- [ ] **Company is an MSP or MSSP** (Managed Service Provider / Managed Security Service Provider)
  - Look for: "Managed Services", "MSSP", "SOC-as-a-Service", "SIEM provider"
  - Red flag: Product companies, consulting firms (unless they run ELK operations)

- [ ] **Elastic/ELK stack is their money maker**
  - ELK/SIEM IS how they make money (core business, not one of many tools)
  - Look for: "Managed SIEM", "Security Monitoring", "SOC services", "SIEM-as-a-Service"
  - Red flag: Companies where ELK is "one of many tools" (not core)

- [ ] **Cybersecurity focus**
  - Security/SOC/SIEM is their business, not generic IT services
  - Look for: "Cybersecurity", "Security Operations", "SOC", "Managed Detection and Response"
  - Red flag: General IT services where security is just an add-on

- [ ] **On-prem deployment (NOT cloud SIEM)**
  - They run ELK on their own servers, NOT cloud SIEMs like:
    - Google SecOps (GCP)
    - Splunk Cloud
    - Datadog
    - Sumo Logic
    - Microsoft Sentinel (cloud-only deployments)
  - Look for: "On-prem", "Self-hosted", "Data center", "Customer data lake"
  - Red flag: "Cloud-native", "SaaS-only", "Zero infrastructure"

- [ ] **Has data center/on-prem server infrastructure**
  - People with server management or data center experience
  - Look for: "Data center", "On-prem servers", "Infrastructure operations", "Site reliability"
  - Red flag: Cloud-only companies

- [ ] **Company size < 200 employees**
  - Small to medium where they can't hire more
  - Look for: "51-200 employees", "Small business", "SMB", "Startup", "Growing company"
  - Red flag: Large enterprises (500+, 1000+, Fortune 500)

## Additional Qualifiers (Nice to Have)

- [ ] **Hiring for ELK/infrastructure roles**
  - Look for: job postings, LinkedIn announcements, "We're hiring"
  - Sign of understaffed team, budget exists but hiring is hard

- [ ] **Customer-facing SIEM/monitoring services**
  - They provide SIEM services TO customers, not just internal use
  - Look for: "We provide", "Our customers", "Managed services for"
  - Red flag: Internal-only tooling

- [ ] **Evidence of ELK pain/challenges**
  - They talk about ELK challenges (shard issues, pipeline debugging, scaling problems)
  - Look for: blog posts, case studies, conference talks, social media mentions
  - Red flag: Only positive marketing content (no real problems)

## Red Flags (Auto-Disqualify)

If you see ANY of these, the company is NOT a fit:

- ❌ Uses cloud SIEM (Google SecOps, Splunk Cloud, Datadog, etc.) instead of on-prem ELK
- ❌ Large enterprise (500+ employees, Fortune 500)
- ❌ ELK is "one of many tools" (not core business)
- ❌ Product company, not service provider
- ❌ Consulting firm that doesn't run ELK operations
- ❌ Cloud-native/SaaS-only (no on-prem infrastructure)
- ❌ IT services firm where security is just an add-on

## Verification Methods

1. **Website/About page** - Check company description, size, services
2. **LinkedIn** - Check employee count, company type, recent posts
3. **Blog/content** - Check for ELK challenges, on-prem mentions, customer stories
4. **Job postings** - Check for ELK/infrastructure roles (sign of understaffing)
5. **Customer reviews** - Check G2, Gartner, Capterra for customer types and pain points

## Usage

**Use this checklist EVERY TIME:**
- ✅ Before qualifying a company as "Target"
- ✅ Before marking a VP/Director as "High Priority"
- ✅ Before adding to CRM as a hot prospect
- ✅ When researching new companies from LinkedIn/Reddit

## Examples

**✅ QUALIFIED (Saka-like):**
- OmniSock SOC
  - MSP/MSSP ✓
  - ELK is money maker ✓
  - Cybersecurity ✓
  - On-prem ✓
  - Data center infrastructure ✓
  - < 200 employees ✓

**❌ DISQUALIFIED:**
- Foresite Cybersecurity
  - MSP/MSSP ✓
  - ELK is money maker ✓
  - Cybersecurity ✓
  - ❌ Cloud SIEM (Google SecOps, not on-prem)
  - ❌ No on-prem infrastructure (they use customer integrations)

- UnderDefense
  - MSP/MSSP ✓
  - ❌ ELK is NOT money maker (they integrate with ELK, don't run it)
  - Cybersecurity ✓
  - ❌ Own platform (MAXI), not ELK operations
  - Partnership opportunity, NOT direct customer

---

**Last updated:** 2026-04-02
**Purpose:** Qualify companies that run on-prem Elastic/ELK stacks as core business (small MSPs/MSSPs where ELK = revenue)
