---
name: crm-debug
description: Debugging CRM objects not showing entries despite data existing in database
metadata: { "openclaw": { "inject": true } }
---

# CRM Debugging

This skill helps debug why an object shows no entries in the UI even when data exists in the database.

---

## Symptom

- Object exists in `objects` table (check via `.object.yaml` or API `/api/workspace/objects/{name}`)
- Entries exist in `entries` table for that object_id
- API returns `"entries": []` and `"totalCount": 0`

---

## Root Cause: Missing PIVOT View

The CRM uses an EAV (Entity-Attribute-Value) pattern. The API queries data through auto-generated **PIVOT views** (`v_{object_name}`). Without this view, the API cannot read the entry data.

**Objects with views**: company, conversation, lead, people, task, vp_prospect  
**Missing view**: any object created manually that doesn't have `v_{name}` view

---

## Debug Steps

### 1. Verify data exists in database

```sql
-- Check object exists
SELECT id, name FROM objects WHERE name = 'team_leads';

-- Check entries exist (use the object_id from above)
SELECT COUNT(*) FROM entries WHERE object_id = 'obj_team_leads_001';

-- Check field values exist
SELECT f.name as field_name, ef.value
FROM entries e
JOIN entry_fields ef ON ef.entry_id = e.id
JOIN fields f ON f.id = ef.field_id
WHERE e.object_id = 'obj_team_leads_001';
```

### 2. Check if PIVOT view exists

```sql
SELECT table_name FROM information_schema.views 
WHERE table_name = 'v_team_leads';
```

If 0 rows: view is missing.

### 3. Identify field names for the object

```sql
SELECT name FROM fields
WHERE object_id = (SELECT id FROM objects WHERE name = 'team_leads')
  AND type != 'action'
ORDER BY sort_order;
```

### 4. Create the missing PIVOT view

```sql
CREATE OR REPLACE VIEW v_team_leads AS
PIVOT (
  SELECT e.id as entry_id, e.created_at, e.updated_at,
         f.name as field_name, ef.value
  FROM entries e
  JOIN entry_fields ef ON ef.entry_id = e.id
  JOIN fields f ON f.id = ef.field_id
  WHERE e.object_id = (SELECT id FROM objects WHERE name = 'team_leads')
    AND f.type != 'action'
) ON field_name IN ('Full Name','Title','Company',...) USING first(value);
```

**IMPORTANT**: List all field names explicitly in the `IN (...)` clause. Omitting it causes schema drift.

### 5. Verify fix

```sql
SELECT * FROM v_team_leads;
```

Or call the API:
```
GET /api/workspace/objects/team_leads
```

Should now return entries and `"totalCount": > 0`.

---

## Prevention

When creating a new object via `.object.yaml`, ensure the PIVOT view is created after the first entry is added. Check if existing objects have views (`v_{name}`) and create any missing ones.

Run this to find all objects without views:

```sql
SELECT o.name as object_name
FROM objects o
LEFT JOIN information_schema.views v ON v.table_name = 'v_' || o.name
WHERE v.table_name IS NULL;
```