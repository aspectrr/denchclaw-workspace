# SKILL.md — CRM VP Prospect Management

Manage the `vp_prospect` CRM object: adding prospects, updating fields, querying the pipeline.

## vp_prospect Object Schema

**Object ID:** `(SELECT id FROM objects WHERE name = 'vp_prospect')`
**Field IDs (verified, do not guess):**
- Full Name: `275e088b-f489-4fa4-bb17-660ad0794d46`
- Title: `384dc5da-8ca4-400c-b436-80c3d6905c07`
- Company: `ff7d4277-1ffb-43b3-9681-7d72ee49b00e`
- Company Size: `d35cd7ab-87b3-449a-bd7e-fe94ee5ac700`
- LinkedIn URL: `ad1709b9-ac4f-44dd-b241-656f76b6a903`
- Status: `494ad717-d3a1-4d34-b79c-ccfcaa63ac6d`
- Priority: `d2a82c40-5ac1-4ade-be7e-e2574dfb85b3`
- Pain Signals: `4dd04f7e-2a0d-4cf0-aa8e-261e8f36dce5`
- Last Activity: `43e178ff-d8b7-4289-9c16-6427a2ddfd59`

## company Object Schema

**Object ID:** `seed_obj_company_0000000000000`
**Field IDs (verified, do not guess):**
- Company Name: `seed_fld_company_name_000000000`
- Industry: `seed_fld_company_industry_00000`
- Type: `seed_fld_company_type_000000000` (9 zeros — common mistake is 6 zeros)
- Website: `seed_fld_company_website_000000`
- Notes: `seed_fld_company_notes_00000000`

### Recommended Company Types
- `Target - Hot` — Small/medium company, ELK is mission-critical, strong prospect fit
- `Target - Medium` — Decent fit, worth exploring
- `Too Large` — Company too big with too many resources (Discord, Goldman, Stripe, etc.)
- `Not ICP` — Doesn't match target persona

## Status Pipeline
```
New → Researched → Pending → Connected
         ↓
      Not ICP
```

### Status Values
- **New** — Just added, not yet contacted
- **Researched** — Profile reviewed, ready for outreach
- **Pending** — Connection request sent, awaiting acceptance
- **Connected** — They accepted, ready for outreach message
- **Follow-Only** — 3rd+ degree, can't connect (note in Pain Signals)
- **Not ICP** — Doesn't match ICP, deprioritized

## Adding a Prospect

```sql
BEGIN TRANSACTION;

INSERT INTO entries (id, object_id, created_at, updated_at) 
VALUES ('{uuid}', (SELECT id FROM objects WHERE name = 'vp_prospect'), NOW(), NOW());

INSERT INTO entry_fields (entry_id, field_id, value, created_at, updated_at) VALUES
('{uuid}', '275e088b-f489-4fa4-bb17-660ad0794d46', '{Full Name}', NOW(), NOW()),
('{uuid}', '384dc5da-8ca4-400c-b436-80c3d6905c07', '{Title}', NOW(), NOW()),
('{uuid}', 'ff7d4277-1ffb-43b3-9681-7d72ee49b00e', '{Company}', NOW(), NOW()),
('{uuid}', 'd35cd7ab-87b3-449a-bd7e-fe94ee5ac700', '{Company Size}', NOW(), NOW()),
('{uuid}', 'ad1709b9-ac4f-44dd-b241-656f76b6a903', '{LinkedIn URL}', NOW(), NOW()),
('{uuid}', '494ad717-d3a1-4d34-b79c-ccfcaa63ac6d', 'New', NOW(), NOW()),
('{uuid}', 'd2a82c40-5ac1-4ade-be7e-e2574dfb85b3', '{High/Medium/Low}', NOW(), NOW()),
('{uuid}', '4dd04f7e-2a0d-4cf0-aa8e-261e8f36dce5', '{Pain Signals}', NOW(), NOW()),
('{uuid}', '43e178ff-d8b7-4289-9c16-6427a2ddfd59', '{Last Activity}', NOW(), NOW());

COMMIT;
```

## Updating Connection Status

```sql
UPDATE entry_fields 
SET value = '{New Status}', updated_at = NOW()
WHERE entry_id = '{entry_id}'
  AND field_id = '494ad717-d3a1-4d34-b79c-ccfcaa63ac6d';
```

## Querying the Pipeline

**All prospects sorted by status:**
```sql
SELECT 
  e.id,
  MAX(CASE WHEN f.name = 'Full Name' THEN ef.value END) as full_name,
  MAX(CASE WHEN f.name = 'Company' THEN ef.value END) as company,
  MAX(CASE WHEN f.name = 'Title' THEN ef.value END) as title,
  MAX(CASE WHEN f.name = 'Status' THEN ef.value END) as status,
  MAX(CASE WHEN f.name = 'Priority' THEN ef.value END) as priority,
  MAX(CASE WHEN f.name = 'Pain Signals' THEN ef.value END) as pain_signals,
  MAX(CASE WHEN f.name = 'Last Activity' THEN ef.value END) as last_activity
FROM entries e
JOIN entry_fields ef ON e.id = ef.entry_id
JOIN fields f ON ef.field_id = f.id
WHERE e.object_id = (SELECT id FROM objects WHERE name = 'vp_prospect')
GROUP BY e.id
ORDER BY 
  CASE MAX(CASE WHEN f.name = 'Status' THEN ef.value END)
    WHEN 'New' THEN 1
    WHEN 'Researched' THEN 2
    WHEN 'Pending' THEN 3
    WHEN 'Connected' THEN 4
    ELSE 5
  END,
  CASE MAX(CASE WHEN f.name = 'Priority' THEN ef.value END)
    WHEN 'High' THEN 1
    WHEN 'Medium' THEN 2
    WHEN 'Low' THEN 3
    ELSE 4
  END;
```

**Pending connections (ready for outreach):**
```sql
SELECT e.id,
  MAX(CASE WHEN f.name = 'Full Name' THEN ef.value END) as full_name,
  MAX(CASE WHEN f.name = 'Company' THEN ef.value END) as company,
  MAX(CASE WHEN f.name = 'Title' THEN ef.value END) as title,
  MAX(CASE WHEN f.name = 'LinkedIn URL' THEN ef.value END) as linkedin,
  MAX(CASE WHEN f.name = 'Pain Signals' THEN ef.value END) as pain_signals
FROM entries e
JOIN entry_fields ef ON e.id = ef.entry_id
JOIN fields f ON ef.field_id = f.id
WHERE e.object_id = (SELECT id FROM objects WHERE name = 'vp_prospect')
  AND ef.field_id = '494ad717-d3a1-4d34-b79c-ccfcaa63ac6d'
  AND ef.value = 'Connected'
GROUP BY e.id;
```

## Adding Notes After Outreach
```sql
UPDATE entry_fields 
SET value = CONCAT(value, ' | {new note}'), updated_at = NOW()
WHERE entry_id = '{entry_id}'
  AND field_id = '4dd04f7e-2a0d-4cf0-aa8e-261e8f36dce5';
```

## Adding a Company

```sql
BEGIN TRANSACTION;

INSERT INTO entries (id, object_id, created_at, updated_at) 
VALUES ('{uuid}', 'seed_obj_company_0000000000000', NOW(), NOW());

INSERT INTO entry_fields (entry_id, field_id, value, created_at, updated_at) VALUES
('{uuid}', 'seed_fld_company_name_000000000', '{Company Name}', NOW(), NOW()),
('{uuid}', 'seed_fld_company_industry_00000', '{Industry}', NOW(), NOW()),
('{uuid}', 'seed_fld_company_type_000000000', '{Type}', NOW(), NOW()),  -- 9 zeros!
('{uuid}', 'seed_fld_company_website_000000', '{Website}', NOW(), NOW()),
('{uuid}', 'seed_fld_company_notes_00000000', '{Notes}', NOW(), NOW());

COMMIT;
```

## Quick Stats
```sql
SELECT 
  MAX(CASE WHEN f.name = 'Status' THEN ef.value END) as status,
  COUNT(*) as count
FROM entries e
JOIN entry_fields ef ON e.id = ef.entry_id
JOIN fields f ON ef.field_id = f.id
WHERE e.object_id = (SELECT id FROM objects WHERE name = 'vp_prospect')
GROUP BY 1
ORDER BY count DESC;
```
