#!/bin/bash
# Script to add Reddit ELK leads to CRM

cd /Users/collinpfeifer/.openclaw-dench/workspace

duckdb workspace.duckdb <<'DUCKSCRIPT'
-- Get lead object ID
SET VARIABLE lead_id = (SELECT id FROM objects WHERE name = 'lead');

-- Get field IDs
SET VARIABLE title_id = (SELECT id FROM fields WHERE object_id = getvariable('lead_id') AND name = 'Title');
SET VARIABLE url_id = (SELECT id FROM fields WHERE object_id = getvariable('lead_id') AND name = 'URL');
SET VARIABLE desc_id = (SELECT id FROM fields WHERE object_id = getvariable('lead_id') AND name = 'Description');
SET VARIABLE source_id = (SELECT id FROM fields WHERE object_id = getvariable('lead_id') AND name = 'Source');
SET VARIABLE subreddit_id = (SELECT id FROM fields WHERE object_id = getvariable('lead_id') AND name = 'Subreddit');
SET VARIABLE status_id = (SELECT id FROM fields WHERE object_id = getvariable('lead_id') AND name = 'Status');
SET VARIABLE priority_id = (SELECT id FROM fields WHERE object_id = getvariable('lead_id') AND name = 'Priority');

-- Lead 1: ELK data loss incident
INSERT INTO entries (id, object_id, sort_order, created_at, updated_at)
VALUES ('lead-001', getvariable('lead_id'), 1, now(), now());

INSERT INTO entry_fields (id, entry_id, field_id, value, created_at, updated_at) VALUES
(gen_random_uuid()::VARCHAR, 'lead-001', getvariable('title_id'), 'ELK stack erased all of my team''s data - 5th time in 3 months', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-001', getvariable('url_id'), 'https://www.reddit.com/r/sysadmin/comments/51yd1h/', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-001', getvariable('desc_id'), 'Team maintains ELK stack that keeps losing production data. User is frustrated with reliability issues and data loss incidents. This is the 5th time in 3 months all their data is gone. Critical pain point around ELK stability and maintenance.', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-001', getvariable('source_id'), 'Reddit', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-001', getvariable('subreddit_id'), 'r/sysadmin', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-001', getvariable('status_id'), 'New', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-001', getvariable('priority_id'), 'Critical', now(), now());

-- Lead 2: Logstash pipeline JSON issues
INSERT INTO entries (id, object_id, sort_order, created_at, updated_at)
VALUES ('lead-002', getvariable('lead_id'), 2, now(), now());

INSERT INTO entry_fields (id, entry_id, field_id, value, created_at, updated_at) VALUES
(gen_random_uuid()::VARCHAR, 'lead-002', getvariable('title_id'), 'Logstash pipeline - issue with json log files', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-002', getvariable('url_id'), 'https://www.reddit.com/r/elasticsearch/comments/12ake3p/', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-002', getvariable('desc_id'), 'Struggling to create logstash pipeline for JSON log parsing. Common pain point around pipeline configuration and data transformation. User is actively seeking help with log ingestion issues.', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-002', getvariable('source_id'), 'Reddit', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-002', getvariable('subreddit_id'), 'r/elasticsearch', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-002', getvariable('status_id'), 'New', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-002', getvariable('priority_id'), 'High', now(), now());

-- Lead 3: Splunk to Elasticsearch migration nightmare
INSERT INTO entries (id, object_id, sort_order, created_at, updated_at)
VALUES ('lead-003', getvariable('lead_id'), 3, now(), now());

INSERT INTO entry_fields (id, entry_id, field_id, value, created_at, updated_at) VALUES
(gen_random_uuid()::VARCHAR, 'lead-003', getvariable('title_id'), 'Moved TBs of historical data from Splunk to Elasticsearch - losing my mind', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-003', getvariable('url_id'), 'https://www.reddit.com/r/elasticsearch/comments/1rji2do/', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-003', getvariable('desc_id'), 'Migrating terabytes of historical data from Splunk to Elasticsearch. Everything breaks - memory spikes, exports crawl, bulk indexing chokes. This is a massive data pipeline challenge that could benefit from AI-assisted debugging and automation.', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-003', getvariable('source_id'), 'Reddit', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-003', getvariable('subreddit_id'), 'r/elasticsearch', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-003', getvariable('status_id'), 'New', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-003', getvariable('priority_id'), 'High', now(), now());

-- Lead 4: Interim DevOps needs help with ELK
INSERT INTO entries (id, object_id, sort_order, created_at, updated_at)
VALUES ('lead-004', getvariable('lead_id'), 4, now(), now());

INSERT INTO entry_fields (id, entry_id, field_id, value, created_at, updated_at) VALUES
(gen_random_uuid()::VARCHAR, 'lead-004', getvariable('title_id'), 'Interim DevOps Guy Needs Help Redesigning ELK Cluster', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-004', getvariable('url_id'), 'https://www.reddit.com/r/elasticsearch/comments/eyjunm/', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-004', getvariable('desc_id'), 'Solo DevOps person inherited a proof-of-concept ELK cluster that needs to become production-ready. Peak 580 documents/minute and rising. Small company with limited expertise - perfect target for AI-assisted ELK management.', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-004', getvariable('source_id'), 'Reddit', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-004', getvariable('subreddit_id'), 'r/elasticsearch', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-004', getvariable('status_id'), 'New', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-004', getvariable('priority_id'), 'High', now(), now());

-- Lead 5: Filebeat to Logstash connection issues
INSERT INTO entries (id, object_id, sort_order, created_at, updated_at)
VALUES ('lead-005', getvariable('lead_id'), 5, now(), now());

INSERT INTO entry_fields (id, entry_id, field_id, value, created_at, updated_at) VALUES
(gen_random_uuid()::VARCHAR, 'lead-005', getvariable('title_id'), 'Unable to get logs from filebeat to logstash', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-005', getvariable('url_id'), 'https://www.reddit.com/r/elasticsearch/comments/1ahpsz3/', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-005', getvariable('desc_id'), 'Brand new to Elastic, trying to build home monitoring system. Connection reset errors between filebeat and logstash. Typical beginner ELK pipeline setup struggle that could be automated.', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-005', getvariable('source_id'), 'Reddit', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-005', getvariable('subreddit_id'), 'r/elasticsearch', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-005', getvariable('status_id'), 'New', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-005', getvariable('priority_id'), 'Medium', now(), now());

-- Lead 6: Logstash failing in production
INSERT INTO entries (id, object_id, sort_order, created_at, updated_at)
VALUES ('lead-006', getvariable('lead_id'), 6, now(), now());

INSERT INTO entry_fields (id, entry_id, field_id, value, created_at, updated_at) VALUES
(gen_random_uuid()::VARCHAR, 'lead-006', getvariable('title_id'), 'Logstash Server Failing - Kubernetes ELK setup', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-006', getvariable('url_id'), 'https://www.reddit.com/r/elasticsearch/comments/jiws7u/', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-006', getvariable('desc_id'), 'Setting up ELK on Kubernetes. Concerned about logstash server failing and stopping entire parsing pipeline. Asking about logstash replication/failover. Production reliability concern.', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-006', getvariable('source_id'), 'Reddit', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-006', getvariable('subreddit_id'), 'r/elasticsearch', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-006', getvariable('status_id'), 'New', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-006', getvariable('priority_id'), 'High', now(), now());

-- Lead 7: Metricbeat keeping me up at night
INSERT INTO entries (id, object_id, sort_order, created_at, updated_at)
VALUES ('lead-007', getvariable('lead_id'), 7, now(), now());

INSERT INTO entry_fields (id, entry_id, field_id, value, created_at, updated_at) VALUES
(gen_random_uuid()::VARCHAR, 'lead-007', getvariable('title_id'), 'Metricbeat is still keeping me up at night - mapper cannot be changed', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-007', getvariable('url_id'), 'https://www.reddit.com/r/elasticsearch/comments/1ebwoff/', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-007', getvariable('desc_id'), 'Using Metricbeat in Docker to collect metrics from API endpoint. Getting mapping conflicts (float vs long). Followed quick start guide but still having issues. Classic ELK debugging nightmare.', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-007', getvariable('source_id'), 'Reddit', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-007', getvariable('subreddit_id'), 'r/elasticsearch', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-007', getvariable('status_id'), 'New', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-007', getvariable('priority_id'), 'Medium', now(), now());

-- Lead 8: ELK stack setup for home lab - can't get logs
INSERT INTO entries (id, object_id, sort_order, created_at, updated_at)
VALUES ('lead-008', getvariable('lead_id'), 8, now(), now());

INSERT INTO entry_fields (id, entry_id, field_id, value, created_at, updated_at) VALUES
(gen_random_uuid()::VARCHAR, 'lead-008', getvariable('title_id'), 'Struggling with Elastic Agent Log Forwarding in ELK Stack Setup', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-008', getvariable('url_id'), 'https://www.reddit.com/r/elasticsearch/comments/1hxg8e2/', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-008', getvariable('desc_id'), 'Home lab ELK setup in Docker. Elastic Agent can''t send logs to Elasticsearch/Kibana despite following setup carefully. Certificates configured but logs not flowing. Common ELK setup/debugging pain point.', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-008', getvariable('source_id'), 'Reddit', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-008', getvariable('subreddit_id'), 'r/elasticsearch', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-008', getvariable('status_id'), 'New', now(), now()),
(gen_random_uuid()::VARCHAR, 'lead-008', getvariable('priority_id'), 'Medium', now(), now());

SELECT 'Added 8 Reddit leads successfully' as result;
DUCKSCRIPT