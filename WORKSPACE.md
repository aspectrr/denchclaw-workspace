# Workspace Schema

Auto-generated summary of the workspace database.

## people

- **Description**: Contact management
- **View**: `table`
- **Entries**: 5
- **Fields**:
  - Full Name (`text`) (required)
  - Email Address (`email`) (required)
  - Phone Number (`phone`)
  - Company (`text`)
  - Status (`enum`) — Active, Inactive, Lead
  - Notes (`richtext`)

## company

- **Description**: Company tracking
- **View**: `table`
- **Entries**: 3
- **Fields**:
  - Company Name (`text`) (required)
  - Industry (`enum`) — Technology, Finance, Healthcare, Education, Retail, Other
  - Website (`text`)
  - Type (`enum`) — Client, Partner, Vendor, Prospect
  - Notes (`richtext`)

## task

- **Description**: Task tracking board
- **View**: `kanban`
- **Entries**: 5
- **Fields**:
  - Title (`text`) (required)
  - Description (`text`)
  - Status (`enum`) — In Queue, In Progress, Done
  - Priority (`enum`) — Low, Medium, High
  - Due Date (`date`)
  - Notes (`richtext`)

## lead

- **Description**: Prospective customers from Reddit and other sources
- **View**: `table`
- **Entries**: 8
- **Fields**:
  - Title (`text`) (required)
  - URL (`url`)
  - Description (`richtext`)
  - Posted Date (`date`)
  - Source (`text`)
  - Subreddit (`text`)
  - Status (`enum`) — New, Contacted, Responded, Qualified, Closed
  - Priority (`enum`) — Low, Medium, High, Critical
