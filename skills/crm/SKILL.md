# SKILL.md — CRM VP Prospect Management

Manage the `vp_prospect` CRM object: adding prospects, updating fields, querying the pipeline.

## vp_prospect Object Schema

**Object ID:** `(SELECT id FROM objects WHERE name = 'vp_prospect')`

### Fields
| Field Name | Field ID | Type | Notes |
|------------|----------|------|-------|
| Full Name | `275e088b-f489-4fa4-bb17-660ad0794d46` | text | |
| Title | `384dc5da-8ca4-400c-b436-80c3d6905c07` | text | Exact title from LinkedIn |
| Company | `ff7d4277-1ffb-43b3-9681-7d72ee49b00e` | text | |
| Company Size | `d35cd7ab-87b3-449a-bd7e-fe94ee5ac700` | text | e.g. "1,001-5,000" |
| LinkedIn URL | `ad1709b9-ac4f-44dd-b241-656f76b6a903` | text | Full URL |
| Status | `494ad717-d3a1-4d34-b79c-ccfcaa63ac6d` | text | Pipeline status |
| Priority | `d2a82c40-5ac1-4ade-be7e-e2574dfb85b3` | text | High/Medium/Low |
| Pain Signals | `4dd04f7e-2a0d-4cf0-aa8e-261e8f36dce5` | text | Research notes |
| Last Activity | `43e178ff-d8b7-4289-9c16-6427a2ddfd59` | text | e.g. "3w ago" |

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
