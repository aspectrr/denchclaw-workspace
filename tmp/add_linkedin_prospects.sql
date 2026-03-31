-- LinkedIn Prospects Insert Script
-- Run this in DuckDB to add all 13 LinkedIn prospects

-- Prospect 1: Jogendra Ayatha (TOP PRIORITY)
INSERT INTO entry_fields (entry_id, field_id, value) VALUES 
  ('7b3191e6-e7d6-4659-b0d6-139c52c36fce', (SELECT id FROM fields WHERE name = 'Title' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Jogendra Ayatha - Sr SRE at MHK (Open to Opportunities)'),
  ('7b3191e6-e7d6-4659-b0d6-139c52c36fce', (SELECT id FROM fields WHERE name = 'LinkedIn URL' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'https://www.linkedin.com/in/jogendraayatha/'),
  ('7b3191e6-e7d6-4659-b0d6-139c52c36fce', (SELECT id FROM fields WHERE name = 'Description' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), '10+ years as SRE/DevOps. Explicitly lists ELK Stack in title. Experience with enterprise-grade monitoring and observability using ELK Stack, Prometheus, Grafana. Automated alerts and incident management. Active job seeker - currently available. Worked at Walgreens, Humana, Bank of America - all high-stakes on-call environments.'),
  ('7b3191e6-e7d6-4659-b0d6-139c52c36fce', (SELECT id FROM fields WHERE name = 'Source' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'LinkedIn'),
  ('7b3191e6-e7d6-4659-b0d6-139c52c36fce', (SELECT id FROM fields WHERE name = 'Status' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'New'),
  ('7b3191e6-e7d6-4659-b0d6-139c52c36fce', (SELECT id FROM fields WHERE name = 'Priority' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Critical'),
  ('7b3191e6-e7d6-4659-b0d6-139c52c36fce', (SELECT id FROM fields WHERE name = 'Posted Date' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), '2026-03-30'),
  ('7b3191e6-e7d6-4659-b0d6-139c52c36fce', (SELECT id FROM fields WHERE name = 'Lead Age' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Fresh (<30 days)');

-- Prospect 2: Snehal Bairagi
INSERT INTO entry_fields (entry_id, field_id, value) VALUES 
  ('37cbc5d5-dd6c-4d6b-828f-41f27106f547', (SELECT id FROM fields WHERE name = 'Title' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Snehal Bairagi - ELK Support Engineer at LTIMindtree'),
  ('37cbc5d5-dd6c-4d6b-828f-41f27106f547', (SELECT id FROM fields WHERE name = 'LinkedIn URL' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'https://www.linkedin.com/in/snehal-bairagi-291718227/'),
  ('37cbc5d5-dd6c-4d6b-828f-41f27106f547', (SELECT id FROM fields WHERE name = 'Description' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Actively posts about Logstash debugging issues including Avoiding Duplicate Logs in Elasticsearch, JDBC pipeline configuration, cluster bootstrap errors. Hands-on experience troubleshooting Logstash pipelines with grok filters and data parsing issues. Supports production ELK stack upgrades and pipeline optimizations.'),
  ('37cbc5d5-dd6c-4d6b-828f-41f27106f547', (SELECT id FROM fields WHERE name = 'Source' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'LinkedIn'),
  ('37cbc5d5-dd6c-4d6b-828f-41f27106f547', (SELECT id FROM fields WHERE name = 'Status' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'New'),
  ('37cbc5d5-dd6c-4d6b-828f-41f27106f547', (SELECT id FROM fields WHERE name = 'Priority' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'High'),
  ('37cbc5d5-dd6c-4d6b-828f-41f27106f547', (SELECT id FROM fields WHERE name = 'Posted Date' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), '2026-03-30'),
  ('37cbc5d5-dd6c-4d6b-828f-41f27106f547', (SELECT id FROM fields WHERE name = 'Lead Age' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Fresh (<30 days)');

-- Prospect 3: Mohannad Elewaily
INSERT INTO entry_fields (entry_id, field_id, value) VALUES 
  ('f06f53a8-2ca1-4f6c-9f3f-a1c76748c2fb', (SELECT id FROM fields WHERE name = 'Title' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Mohannad Elewaily - Senior Observability/Elasticsearch Engineer at EJADA Egypt'),
  ('f06f53a8-2ca1-4f6c-9f3f-a1c76748c2fb', (SELECT id FROM fields WHERE name = 'LinkedIn URL' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'https://www.linkedin.com/in/mohannad-elewaily/'),
  ('f06f53a8-2ca1-4f6c-9f3f-a1c76748c2fb', (SELECT id FROM fields WHERE name = 'Description' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Specializes in platform migrations between observability tools. Experience designing, migrating, and operating production logging platforms. Works at the intersection of Elasticsearch migrations and cloud operations.'),
  ('f06f53a8-2ca1-4f6c-9f3f-a1c76748c2fb', (SELECT id FROM fields WHERE name = 'Source' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'LinkedIn'),
  ('f06f53a8-2ca1-4f6c-9f3f-a1c76748c2fb', (SELECT id FROM fields WHERE name = 'Status' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'New'),
  ('f06f53a8-2ca1-4f6c-9f3f-a1c76748c2fb', (SELECT id FROM fields WHERE name = 'Priority' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'High'),
  ('f06f53a8-2ca1-4f6c-9f3f-a1c76748c2fb', (SELECT id FROM fields WHERE name = 'Posted Date' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), '2026-03-30'),
  ('f06f53a8-2ca1-4f6c-9f3f-a1c76748c2fb', (SELECT id FROM fields WHERE name = 'Lead Age' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Fresh (<30 days)');

-- Prospect 4: Marripati Tarakeswar Reddy
INSERT INTO entry_fields (entry_id, field_id, value) VALUES 
  ('16bc42ec-f5a9-4ad4-9a0d-4afdbadb46f2', (SELECT id FROM fields WHERE name = 'Title' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Marripati Tarakeswar Reddy - Seeking ELK Operational Support'),
  ('16bc42ec-f5a9-4ad4-9a0d-4afdbadb46f2', (SELECT id FROM fields WHERE name = 'LinkedIn URL' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'https://www.linkedin.com/in/marripati-tarakeswar-reddy-1481b8243/'),
  ('16bc42ec-f5a9-4ad4-9a0d-4afdbadb46f2', (SELECT id FROM fields WHERE name = 'Description' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Explicitly seeking ELK operational support roles. Expertise in installing, upgrading, and configuring ELK through Ansible - knows the pain points firsthand.'),
  ('16bc42ec-f5a9-4ad4-9a0d-4afdbadb46f2', (SELECT id FROM fields WHERE name = 'Source' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'LinkedIn'),
  ('16bc42ec-f5a9-4ad4-9a0d-4afdbadb46f2', (SELECT id FROM fields WHERE name = 'Status' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'New'),
  ('16bc42ec-f5a9-4ad4-9a0d-4afdbadb46f2', (SELECT id FROM fields WHERE name = 'Priority' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'High'),
  ('16bc42ec-f5a9-4ad4-9a0d-4afdbadb46f2', (SELECT id FROM fields WHERE name = 'Posted Date' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), '2026-03-30'),
  ('16bc42ec-f5a9-4ad4-9a0d-4afdbadb46f2', (SELECT id FROM fields WHERE name = 'Lead Age' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Fresh (<30 days)');

-- Prospect 5: Fram Souza (works at Elastic)
INSERT INTO entry_fields (entry_id, field_id, value) VALUES 
  ('5c850f44-e046-4b30-ab53-154529c89ce7', (SELECT id FROM fields WHERE name = 'Title' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Fram Souza - Senior SRE at Elastic'),
  ('5c850f44-e046-4b30-ab53-154529c89ce7', (SELECT id FROM fields WHERE name = 'LinkedIn URL' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'https://www.linkedin.com/in/francismarasouza/'),
  ('5c850f44-e046-4b30-ab53-154529c89ce7', (SELECT id FROM fields WHERE name = 'Description' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), '5+ years AT Elastic, currently Senior SRE. Specializes in Kubernetes and automation to incident response, on-call excellence. Created AI agent for managing Elasticsearch Serverless projects. Deep expertise in running Elastic on Kubernetes at scale. NOTE: Works at Elastic - learning opportunity, not customer.'),
  ('5c850f44-e046-4b30-ab53-154529c89ce7', (SELECT id FROM fields WHERE name = 'Source' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'LinkedIn'),
  ('5c850f44-e046-4b30-ab53-154529c89ce7', (SELECT id FROM fields WHERE name = 'Status' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'New'),
  ('5c850f44-e046-4b30-ab53-154529c89ce7', (SELECT id FROM fields WHERE name = 'Priority' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Medium'),
  ('5c850f44-e046-4b30-ab53-154529c89ce7', (SELECT id FROM fields WHERE name = 'Posted Date' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), '2026-03-30'),
  ('5c850f44-e046-4b30-ab53-154529c89ce7', (SELECT id FROM fields WHERE name = 'Lead Age' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Fresh (<30 days)');

-- Prospect 6: Jeff Tharp (works at Elastic)
INSERT INTO entry_fields (entry_id, field_id, value) VALUES 
  ('3b270211-6ccc-485a-b3bd-f9694b3e4b4e', (SELECT id FROM fields WHERE name = 'Title' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Jeff Tharp - Principal SRE at Elastic'),
  ('3b270211-6ccc-485a-b3bd-f9694b3e4b4e', (SELECT id FROM fields WHERE name = 'LinkedIn URL' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'https://www.linkedin.com/in/jtharpla/'),
  ('3b270211-6ccc-485a-b3bd-f9694b3e4b4e', (SELECT id FROM fields WHERE name = 'Description' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), '7 years at Elastic supporting Elastic Cloud operations across AWS, Azure, GCP in 60+ regions. Maintains Terraform codebase for multi-cloud infrastructure. Previously led implementation of Elasticsearch-as-a-service offering at ObjectRocket. 26 years of infrastructure experience, 9 years as SRE/DevOps. NOTE: Works at Elastic - learning opportunity, not customer.'),
  ('3b270211-6ccc-485a-b3bd-f9694b3e4b4e', (SELECT id FROM fields WHERE name = 'Source' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'LinkedIn'),
  ('3b270211-6ccc-485a-b3bd-f9694b3e4b4e', (SELECT id FROM fields WHERE name = 'Status' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'New'),
  ('3b270211-6ccc-485a-b3bd-f9694b3e4b4e', (SELECT id FROM fields WHERE name = 'Priority' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Medium'),
  ('3b270211-6ccc-485a-b3bd-f9694b3e4b4e', (SELECT id FROM fields WHERE name = 'Posted Date' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), '2026-03-30'),
  ('3b270211-6ccc-485a-b3bd-f9694b3e4b4e', (SELECT id FROM fields WHERE name = 'Lead Age' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Fresh (<30 days)');

-- Prospect 7: Alec Bell
INSERT INTO entry_fields (entry_id, field_id, value) VALUES 
  ('238635f3-c136-44e6-a17d-03139bdf9c11', (SELECT id FROM fields WHERE name = 'Title' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Alec Bell - Professional Services Cloud Migration Architect at Splunk'),
  ('238635f3-c136-44e6-a17d-03139bdf9c11', (SELECT id FROM fields WHERE name = 'LinkedIn URL' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'https://www.linkedin.com/in/alec-bell-668526134/'),
  ('238635f3-c136-44e6-a17d-03139bdf9c11', (SELECT id FROM fields WHERE name = 'Description' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), '6+ years at Splunk as a Cloud Migration Architect. Specializes in migrating customers TO Splunk, making him aware of migration pain points from other platforms. Has Splunk Accredited Cloud Migration Consultant certification. NOTE: Works at competitor (Splunk) - learning opportunity, potential insight into migration challenges.'),
  ('238635f3-c136-44e6-a17d-03139bdf9c11', (SELECT id FROM fields WHERE name = 'Source' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'LinkedIn'),
  ('238635f3-c136-44e6-a17d-03139bdf9c11', (SELECT id FROM fields WHERE name = 'Status' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'New'),
  ('238635f3-c136-44e6-a17d-03139bdf9c11', (SELECT id FROM fields WHERE name = 'Priority' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Medium'),
  ('238635f3-c136-44e6-a17d-03139bdf9c11', (SELECT id FROM fields WHERE name = 'Posted Date' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), '2026-03-30'),
  ('238635f3-c136-44e6-a17d-03139bdf9c11', (SELECT id FROM fields WHERE name = 'Lead Age' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Fresh (<30 days)');

-- Prospect 8: Praveen Padmanabhuni
INSERT INTO entry_fields (entry_id, field_id, value) VALUES 
  ('09efcb4d-6395-4390-b949-cd11308fce91', (SELECT id FROM fields WHERE name = 'Title' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Praveen Padmanabhuni - Senior Search Consultant - Elasticsearch SME'),
  ('09efcb4d-6395-4390-b949-cd11308fce91', (SELECT id FROM fields WHERE name = 'LinkedIn URL' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'https://www.linkedin.com/in/praveen-pmnv/'),
  ('09efcb4d-6395-4390-b949-cd11308fce91', (SELECT id FROM fields WHERE name = 'Description' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Works on Fastenal product search platform with Elasticsearch-AI driven solutions. Would be acutely aware of data quality issues affecting search relevance and accuracy.'),
  ('09efcb4d-6395-4390-b949-cd11308fce91', (SELECT id FROM fields WHERE name = 'Source' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'LinkedIn'),
  ('09efcb4d-6395-4390-b949-cd11308fce91', (SELECT id FROM fields WHERE name = 'Status' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'New'),
  ('09efcb4d-6395-4390-b949-cd11308fce91', (SELECT id FROM fields WHERE name = 'Priority' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Medium'),
  ('09efcb4d-6395-4390-b949-cd11308fce91', (SELECT id FROM fields WHERE name = 'Posted Date' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), '2026-03-30'),
  ('09efcb4d-6395-4390-b949-cd11308fce91', (SELECT id FROM fields WHERE name = 'Lead Age' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Fresh (<30 days)');

-- Prospect 9: Itshak Hillel (Eli)
INSERT INTO entry_fields (entry_id, field_id, value) VALUES 
  ('1efd87d5-46c3-4ddd-aee1-5470b5770e64', (SELECT id FROM fields WHERE name = 'Title' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Itshak Hillel (Eli) - Self Employed DevOps & Cloud Architect'),
  ('1efd87d5-46c3-4ddd-aee1-5470b5770e64', (SELECT id FROM fields WHERE name = 'LinkedIn URL' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'https://www.linkedin.com/in/itshak-hillel-eli-7a359652/'),
  ('1efd87d5-46c3-4ddd-aee1-5470b5770e64', (SELECT id FROM fields WHERE name = 'Description' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Self-employed consultant revolving around open-source solutions and Elasticsearch. Sees many data integrity issues across client implementations.'),
  ('1efd87d5-46c3-4ddd-aee1-5470b5770e64', (SELECT id FROM fields WHERE name = 'Source' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'LinkedIn'),
  ('1efd87d5-46c3-4ddd-aee1-5470b5770e64', (SELECT id FROM fields WHERE name = 'Status' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'New'),
  ('1efd87d5-46c3-4ddd-aee1-5470b5770e64', (SELECT id FROM fields WHERE name = 'Priority' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Medium'),
  ('1efd87d5-46c3-4ddd-aee1-5470b5770e64', (SELECT id FROM fields WHERE name = 'Posted Date' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), '2026-03-30'),
  ('1efd87d5-46c3-4ddd-aee1-5470b5770e64', (SELECT id FROM fields WHERE name = 'Lead Age' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Fresh (<30 days)');

-- Prospect 10: Rakesh Kumar Singh
INSERT INTO entry_fields (entry_id, field_id, value) VALUES 
  ('952949dc-0e70-4ed7-ad48-b7fb5a3db5dd', (SELECT id FROM fields WHERE name = 'Title' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Rakesh Kumar Singh - Observability Expert'),
  ('952949dc-0e70-4ed7-ad48-b7fb5a3db5dd', (SELECT id FROM fields WHERE name = 'LinkedIn URL' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'https://www.linkedin.com/in/rakesh-kumar-singh-b2853363/'),
  ('952949dc-0e70-4ed7-ad48-b7fb5a3db5dd', (SELECT id FROM fields WHERE name = 'Description' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Led integration of external data sources and third-party tools including Fluentd and OpenTelemetry for comprehensive data collection - heavily involved in pipeline debugging.'),
  ('952949dc-0e70-4ed7-ad48-b7fb5a3db5dd', (SELECT id FROM fields WHERE name = 'Source' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'LinkedIn'),
  ('952949dc-0e70-4ed7-ad48-b7fb5a3db5dd', (SELECT id FROM fields WHERE name = 'Status' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'New'),
  ('952949dc-0e70-4ed7-ad48-b7fb5a3db5dd', (SELECT id FROM fields WHERE name = 'Priority' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Medium'),
  ('952949dc-0e70-4ed7-ad48-b7fb5a3db5dd', (SELECT id FROM fields WHERE name = 'Posted Date' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), '2026-03-30'),
  ('952949dc-0e70-4ed7-ad48-b7fb5a3db5dd', (SELECT id FROM fields WHERE name = 'Lead Age' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Fresh (<30 days)');

-- Prospect 11: Ajayan A
INSERT INTO entry_fields (entry_id, field_id, value) VALUES 
  ('7c55fbd4-85a3-4778-9d17-3eba8d93daca', (SELECT id FROM fields WHERE name = 'Title' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Ajayan A - Senior Site Reliability Engineer at IBM'),
  ('7c55fbd4-85a3-4778-9d17-3eba8d93daca', (SELECT id FROM fields WHERE name = 'LinkedIn URL' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'https://www.linkedin.com/in/ajayan-a-85836173/'),
  ('7c55fbd4-85a3-4778-9d17-3eba8d93daca', (SELECT id FROM fields WHERE name = 'Description' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Explicitly mentions ELK Stack in title with focus on uptime/on-call reliability. Specializes in reducing toil through better tooling. 99.99% Uptime Advocate & Toil Reduction Specialist.'),
  ('7c55fbd4-85a3-4778-9d17-3eba8d93daca', (SELECT id FROM fields WHERE name = 'Source' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'LinkedIn'),
  ('7c55fbd4-85a3-4778-9d17-3eba8d93daca', (SELECT id FROM fields WHERE name = 'Status' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'New'),
  ('7c55fbd4-85a3-4778-9d17-3eba8d93daca', (SELECT id FROM fields WHERE name = 'Priority' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'High'),
  ('7c55fbd4-85a3-4778-9d17-3eba8d93daca', (SELECT id FROM fields WHERE name = 'Posted Date' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), '2026-03-30'),
  ('7c55fbd4-85a3-4778-9d17-3eba8d93daca', (SELECT id FROM fields WHERE name = 'Lead Age' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Fresh (<30 days)');

-- Prospect 12: Sanket Tembhare
INSERT INTO entry_fields (entry_id, field_id, value) VALUES 
  ('6fa0f0eb-3e38-4440-9ca9-cb8c7ea67a08', (SELECT id FROM fields WHERE name = 'Title' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Sanket Tembhare - Lead SRE at Major Canadian Banking Clients'),
  ('6fa0f0eb-3e38-4440-9ca9-cb8c7ea67a08', (SELECT id FROM fields WHERE name = 'LinkedIn URL' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'https://www.linkedin.com/in/sanket-tembhare/'),
  ('6fa0f0eb-3e38-4440-9ca9-cb8c7ea67a08', (SELECT id FROM fields WHERE name = 'Description' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Lead SRE at banking clients (high-stakes on-call environment). Combines ELK with Splunk experience - understands migration pain points between platforms.'),
  ('6fa0f0eb-3e38-4440-9ca9-cb8c7ea67a08', (SELECT id FROM fields WHERE name = 'Source' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'LinkedIn'),
  ('6fa0f0eb-3e38-4440-9ca9-cb8c7ea67a08', (SELECT id FROM fields WHERE name = 'Status' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'New'),
  ('6fa0f0eb-3e38-4440-9ca9-cb8c7ea67a08', (SELECT id FROM fields WHERE name = 'Priority' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'High'),
  ('6fa0f0eb-3e38-4440-9ca9-cb8c7ea67a08', (SELECT id FROM fields WHERE name = 'Posted Date' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), '2026-03-30'),
  ('6fa0f0eb-3e38-4440-9ca9-cb8c7ea67a08', (SELECT id FROM fields WHERE name = 'Lead Age' AND object_id = (SELECT id FROM objects WHERE name = 'lead')), 'Fresh (<30 days)');

SELECT '13 LinkedIn prospects added successfully' as result;
