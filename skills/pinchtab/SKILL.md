---
name: pinchtab
description: "Browser automation for general web browsing, reading blogs, Googling, and extracting website information. Use PinchTab when you need to interact with websites that don't have dedicated MCP servers. For Reddit tasks, use reddit-mcp. For LinkedIn tasks, use linkedin-mcp - NEVER use PinchTab for LinkedIn. Use PinchTab for: (1) Searching Google and browsing search results, (2) Reading blogs and articles, (3) General web surfing when no dedicated tool exists, (4) Taking screenshots of websites, (5) Extracting text content from pages, (6) Testing websites or debugging web issues."
---

# PinchTab - General Web BrowserAutomation

## When to Use PinchTab

**Use PinchTab for:**
- Googling things and browsing search results
- Reading blogs, articles, and general web content
- Surfing websites that don't have dedicated MCP servers
- Extracting text content from web pages
- Taking website screenshots
- Debugging or testing websites
- General internet browsing

**Do NOT use PinchTab for:**
- **LinkedIn** → Use `linkedin-mcp` instead (search_people, get_person_profile, get_company_profile, etc.)
- **Reddit** → Use `reddit-mcp` instead (reddit_search, reddit_get_subreddit_posts, etc.)

**Rule:** Before using PinchTab for a specific website, check if a dedicated MCP server exists for that platform. Use the specialized tool when available.

## Quick Start

```
1. Navigate: pinchtab_navigate({ url: "https://example.com" })
2. Snapshot: pinchtab_snapshot() - Get page structure
3. Interact: pinchtab_click({ selector: "e5" }), pinchtab_type({ selector: "e10", text: "search query" })
4. Extract: pinchtab_get_text() or pinchtab_screenshot()
```

## Common Workflows

### Googling Something

1. Navigate to Google: `pinchtab_navigate({ url: "https://google.com" })`
2. Wait for load: `pinchtab_wait_for_load({ load: "networkidle" })`
3. Type query: `pinchtab_type({ selector: "input[name='q']", text: "your search" })`
4. Submit: `pinchtab_press({ key: "Enter" })`
5. Wait for results: `pinchtab_wait_for_load({ load: "networkidle" })`
6. Get results: `pinchtab_snapshot()` or `pinchtab_get_text()`

### Reading a Blog/Article

1. Navigate: `pinchtab_navigate({ url: "https://blog.example.com/article" })`
2. Wait for load: `pinchtab_wait_for_load({ load: "networkidle" })`
3. Extract text: `pinchtab_get_text()`
4. Or screenshot: `pinchtab_screenshot()`

### Extracting Page Content

```
pinchtab_get_text() - Clean text extraction
pinchtab_snapshot() - Accessibility tree (shows interactive elements)
pinchtab_screenshot() - Visual capture
```

### Interacting with Forms

1. Find element: `pinchtab_find({ query: "email" })` or `pinchtab_snapshot()`
2. Type input: `pinchtab_type({ selector: "input#email", text: "value" })`
3. Click submit: `pinchtab_click({ selector: "button[type='submit']" })`
4. Wait for response: `pinchtab_wait_for_load({ load: "networkidle" })`

## Key Tools

| Tool | Purpose |
|------|---------|
| `pinchtab_navigate` | Go to a URL |
| `pinchtab_snapshot` | Get page structure (elements shown as e1, e2, e3...) |
| `pinchtab_get_text` | Extract readable text content |
| `pinchtab_screenshot` | Take a visual screenshot |
| `pinchtab_click` | Click element by selector |
| `pinchtab_type` | Type text into input |
| `pinchtab_fill` | Fill input via JavaScript (faster, no key events) |
| `pinchtab_find` | Find elements by text or CSS |
| `pinchtab_wait_for_load` | Wait for page state |
| `pinchtab_wait_for_selector` | Wait for element to appear |
| `pinchtab_press` | Press keyboard key (Enter, Escape, Tab...) |

## Selector Formats

PinchTab supports multiple selector types:
- **Element refs**: `"e5"` - From snapshot output (recommended)
- **CSS selectors**: `"input#email"`, `"button.submit"`
- **Textfind**: `{ text: "Submit" }` - Find by visible text

**Tip:** Use `pinchtab_snapshot()` first to see element refs (e1, e2, e3...), then click/type using those refs for reliability.

## Best Practices

1. **Wait after navigation:** Always `wait_for_load({ load: "networkidle" })` after navigating
2. **Use snapshots:** `pinchtab_snapshot()` gives you the page structure with stable element refs
3. **Retry logic:** If an action fails, take a new snapshot (page may have changed)
4. **Clean up:** Use `pinchtab_close_tab()` when done with a page

## Decision Tree

```
User wants to...
│
├─ Google something─────────────────→ PinchTabnavigate → type → search
│
├─ Read a blog/article ─────────────→ PinchTab navigate → get_text
│
├─ Browse general websites ─────────→ PinchTab navigate → snapshot → interact
│
├─ Work with LinkedIn───────────────→ linkedin-mcp (NOT PinchTab!)
│
├─ Work with Reddit ────────────────→ reddit-mcp (NOT PinchTab!)
│
└─ Screenshot/debug a site ─────────→ PinchTab navigate → screenshot
```

## MCP Server Priority

**Always check for dedicated MCP servers first:**

| Website | Use This Server |
|---------|-----------------|
| LinkedIn | `linkedin-mcp` |
| Reddit | `reddit-mcp` |
| GitHub | `github-mcp` |
| Stack Overflow | `stack-overflow-mcp` |
| General web | `pinchtab-mcp` |

Before using PinchTab for a specific platform, call `mcp action=list` to see available servers and their tools. If a dedicated server exists for your target website, use it instead of PinchTab.