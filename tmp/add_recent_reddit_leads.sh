#!/bin/bash
# Script to add RECENT Reddit ELK leads to CRM with proper dates

cd /Users/collinpfeifer/.openclaw-dench/workspace

duckdb workspace.duckdb <<'DUCKSCRIPT'
-- Get lead object ID
SET VARIABLE lead_id = (SELECT id FROM objects WHERE name = 'lead');

-- Get field IDs
SET VARIABLE title_id = (SELECT id FROM fields WHERE object_id = getvariable('lead_id') AND name = 'Title');
SET VARIABLE url_id = (SELECT id FROM fields WHERE object_id = getvariable('lead_id') AND name = 'URL');
SET VARIABLE desc_id = (SELECT id FROM fields WHERE object_id = getvariable('lead_id') AND name = 'Description');
SET VARIABLE posted_date_id = (SELECT id FROM fields WHERE object_id = getvariable('lead_id') AND name = 'Posted Date');
SET VARIABLE source_id = (SELECT id FROM fields WHERE object_id = getvariable('lead_id') AND name = 'Source');
SET VARIABLE subreddit_id = (SELECT id FROM fields WHERE object_id = getvariable('lead_id') AND name = 'Subreddit');
SET VARIABLE status_id = (SELECT id FROM fields WHERE object_id = getvariable('lead_id') AND name = 'Status');
SET VARIABLE priority_id = (SELECT id FROM fields WHERE object_id = getvariable('lead_id') AND name = 'Priority');

-- Lead 1: Kibana DataViews issue (Recent - March 2026)
INSERT INTO entries (id, object_id, sort_order, created_at, updated_at)
VALUES ('lead-001', getvariable('lead_id'), 1, now(), now());

INSERT INTO entry_fields (id, entry_id, field_id, value, created_at, updated_at) VALUES
(gen_random_uuid()::VARCHAR, 'lead-001', getvariable('title_id'), 'Kibana issue with curl to get DataViews', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-001', getvariable('url_id'), 'https://www.reddit.com/r/elasticsearch/comments/1rvkqdl/', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-001', getvariable('desc_id'), 'User struggling with Kibana DataViews API via curl. 10 comments suggest this is an active troubleshooting thread. Good opportunity to engage with someone actively working with ELK stack APIs.', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-001', getvariable('posted_date_id'), '2026-03-14', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-001', getvariable('source_id'), 'Reddit', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-001', getvariable('subreddit_id'), 'r/elasticsearch', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-001', getvariable('status_id'), 'New', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-001', getvariable('priority_id'), 'Medium', now(), now());

-- Lead 2: Elasticsearch as Jaeger Backend - disk issues (Recent - March 2026)
INSERT INTO entries (id, object_id, sort_order, created_at, updated_at)
VALUES ('lead-002', getvariable('lead_id'), 2, now(), now());

INSERT INTO entry_fields (id, entry_id, field_id, value, created_at, updated_at) VALUES
(gen_random_uuid()::VARCHAR, 'lead-002', getvariable('title_id'), 'Elasticsearch as Jaeger Collector Backend - rapid disk consumption', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-002', getvariable('url_id'), 'https://www.reddit.com/r/elasticsearch/comments/1rq5kgv/', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-002', getvariable('desc_id'), 'Using Elasticsearch as Jaeger backend for tracing. Rapid disk consumption issues. 9 comments, actively troubleshooting. Infrastructure scaling/debugging pain point - exactly what AI-assisted ELK debugging could help with.', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-002', getvariable('posted_date_id'), '2026-03-09', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-002', getvariable('source_id'), 'Reddit', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-002', getvariable('subreddit_id'), 'r/elasticsearch', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-002', getvariable('status_id'), 'New', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-002', getvariable('priority_id'), 'High', now(), now());

-- Lead 3: Create DataView from DevTools (Recent - March 2026)
INSERT INTO entries (id, object_id, sort_order, created_at, updated_at)
VALUES ('lead-003', getvariable('lead_id'), 3, now(), now());

INSERT INTO entry_fields (id, entry_id, field_id, value, created_at, updated_at) VALUES
(gen_random_uuid()::VARCHAR, 'lead-003', getvariable('title_id'), 'Create DataView from DevTools', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-003', getvariable('url_id'), 'https://www.reddit.com/r/elasticsearch/comments/1rqa3i1/', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-003', getvariable('desc_id'), 'User asking about programmatically creating DataViews from DevTools. 3 comments, actively seeking help. Kibana/DevTools workflow automation opportunity.', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-003', getvariable('posted_date_id'), '2026-03-09', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-003', getvariable('source_id'), 'Reddit', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-003', getvariable('subreddit_id'), 'r/elasticsearch', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-003', getvariable('status_id'), 'New', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-003', getvariable('priority_id'), 'Medium', now(), now());

-- Lead 4: Help for NIDS Dashboard (Recent - March 2026)
INSERT INTO entries (id, object_id, sort_order, created_at, updated_at)
VALUES ('lead-004', getvariable('lead_id'), 4, now(), now());

INSERT INTO entry_fields (id, entry_id, field_id, value, created_at, updated_at) VALUES
(gen_random_uuid()::VARCHAR, 'lead-004', getvariable('title_id'), 'Help for my NIDS Dashboard', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-004', getvariable('url_id'), 'https://www.reddit.com/r/elasticsearch/comments/1rsdfin/', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-004', getvariable('desc_id'), 'Network Intrusion Detection System dashboard help request. ELK for security/SIEM use case. 1 comment, opportunity to engage with security-focused ELK user.', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-004', getvariable('posted_date_id'), '2026-03-12', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-004', getvariable('source_id'), 'Reddit', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-004', getvariable('subreddit_id'), 'r/elasticsearch', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-004', getvariable('status_id'), 'New', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-004', getvariable('priority_id'), 'Medium', now(), now());

-- Lead 5: Prod database crash - no monitoring (Recent - March 2026, from r/sysadmin)
INSERT INTO entries (id, object_id, sort_order, created_at, updated_at)
VALUES ('lead-005', getvariable('lead_id'), 5, now(), now());

INSERT INTO entry_fields (id, entry_id, field_id, value, created_at, updated_at) VALUES
(gen_random_uuid()::VARCHAR, 'lead-005', getvariable('title_id'), 'Prod database crash and burn - no one was monitoring it', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-005', getvariable('url_id'), 'https://www.reddit.com/r/sysadmin/comments/1s7kelt/', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-005', getvariable('desc_id'), '231 upvotes, 109 comments. Sysadmin watched production database crash due to lack of monitoring. Asking why companies do reactive IT. PERFECT pain point - reactive vs proactive monitoring, exactly what AI-assisted ELK/on-prem debugging solves. Hair on fire problem.', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-005', getvariable('posted_date_id'), '2026-03-30', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-005', getvariable('source_id'), 'Reddit', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-005', getvariable('subreddit_id'), 'r/sysadmin', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-005', getvariable('status_id'), 'New', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-005', getvariable('priority_id'), 'Critical', now(), now());

-- Lead 6: DevOps woes - operational pain (Recent - March 2026, from r/devops)
INSERT INTO entries (id, object_id, sort_order, created_at, updated_at)
VALUES ('lead-006', getvariable('lead_id'), 6, now(), now());

INSERT INTO entry_fields (id, entry_id, field_id, value, created_at, updated_at) VALUES
(gen_random_uuid()::VARCHAR, 'lead-006', getvariable('title_id'), 'My devops and gitops woes', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-006', getvariable('url_id'), 'https://www.reddit.com/r/devops/comments/1s4r4fk/', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-006', getvariable('desc_id'), '6 upvotes, 16 comments. DevOps engineer sharing operational pain points and struggles. Active discussion about DevOps challenges. Potential opportunity to understand pain points of platform/DevOps teams managing infrastructure.', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-006', getvariable('posted_date_id'), '2026-03-27', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-006', getvariable('source_id'), 'Reddit', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-006', getvariable('subreddit_id'), 'r/devops', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-006', getvariable('status_id'), 'New', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-006', getvariable('priority_id'), 'Medium', now(), now());

-- Lead 7: Split index node requirements (Recent - March 2026)
INSERT INTO entries (id, object_id, sort_order, created_at, updated_at)
VALUES ('lead-007', getvariable('lead_id'), 7, now(), now());

INSERT INTO entry_fields (id, entry_id, field_id, value, created_at, updated_at) VALUES
(gen_random_uuid()::VARCHAR, 'lead-007', getvariable('title_id'), 'Split index node requirements', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-007', getvariable('url_id'), 'https://www.reddit.com/r/elasticsearch/comments/1rz0m1n/', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-007', getvariable('desc_id'), 'User asking about Elasticsearch index splitting and node requirements. Infrastructure scaling question - 1 comment. Opportunity to engage with someone managing ES cluster capacity.', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-007', getvariable('posted_date_id'), '2026-03-20', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-007', getvariable('source_id'), 'Reddit', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-007', getvariable('subreddit_id'), 'r/elasticsearch', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-007', getvariable('status_id'), 'New', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-007', getvariable('priority_id'), 'Low', now(), now());

-- Lead 8: Stuck integrating with encoded msearch (Recent - March 2026)
INSERT INTO entries (id, object_id, sort_order, created_at, updated_at)
VALUES ('lead-008', getvariable('lead_id'), 8, now(), now());

INSERT INTO entry_fields (id, entry_id, field_id, value, created_at, updated_at) VALUES
(gen_random_uuid()::VARCHAR, 'lead-008', getvariable('title_id'), 'Stuck integrating with a system that has no real APIs - only encoded msearch calls', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-008', getvariable('url_id'), 'https://www.reddit.com/r/elasticsearch/comments/1rzqglt/', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-008', getvariable('desc_id'), 'Integration challenge with Elasticsearch msearch API. 1 comment, actively troubleshooting. Complex API integration pain point - could be helped with AI-assisted debugging.', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-008', getvariable('posted_date_id'), '2026-03-22', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-008', getvariable('source_id'), 'Reddit', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-008', getvariable('subreddit_id'), 'r/elasticsearch', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-008', getvariable('status_id'), 'New', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-008', getvariable('priority_id'), 'Medium', now(), now());

SELECT 'Added 8 RECENT Reddit leads with dates' as result;
DUCKSCRIPT