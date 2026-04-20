#!/usr/bin/env python3
import json
import sys
import os
from datetime import datetime
from pathlib import Path

def jsonl_to_markdown(jsonl_path: str, output_dir: str):
    """Convert a single JSONL chat file to markdown."""
    output_path = Path(output_dir) / f"{Path(jsonl_path).stem}.md"
    
    messages = []
    try:
        with open(jsonl_path, 'r') as f:
            for line in f:
                line = line.strip()
                if line:
                    try:
                        messages.append(json.loads(line))
                    except json.JSONDecodeError:
                        continue
    except Exception as e:
        print(f"Error reading {jsonl_path}: {e}")
        return False
    
    if not messages:
        return False
    
    # Extract title from first user message or use filename
    title = messages[0].get('content', '')[:100].split('\n')[0] if messages else Path(jsonl_path).stem
    if len(messages[0].get('content', '')) > 100:
        title = messages[0].get('content', '')[:97] + "..."
    
    lines = [f"# Chat: {title}\n"]
    lines.append(f"**Source:** `{jsonl_path}`\n")
    lines.append(f"**Converted:** {datetime.now().isoformat()}\n")
    lines.append(f"**Messages:** {len(messages)}\n")
    lines.append("---\n\n")
    
    for msg in messages:
        role = msg.get('role', 'unknown')
        content = msg.get('content', '')
        
        if not content:
            continue
            
        # Skip tool calls and errors
        if role == 'system':
            continue
        
        timestamp = msg.get('timestamp', '')
        if timestamp:
            try:
                dt = datetime.fromisoformat(timestamp.replace('Z', '+00:00'))
                ts = dt.strftime('%Y-%m-%d %H:%M')
            except:
                ts = timestamp[:16]
        else:
            ts = ''
        
        lines.append(f"## {role.upper()}")
        if ts:
            lines.append(f"*{ts}*")
        lines.append("")
        lines.append(content[:5000])  # Limit content length
        if len(content) > 5000:
            lines.append(f"\n... *(truncated, original length: {len(content)})*")
        lines.append("\n\n")
    
    try:
        with open(output_path, 'w') as f:
            f.write('\n'.join(lines))
        print(f"Converted: {jsonl_path} -> {output_path}")
        return True
    except Exception as e:
        print(f"Error writing {output_path}: {e}")
        return False

def main():
    if len(sys.argv) < 2:
        print("Usage: python convert_chats.py <jsonl_file_or_directory> [output_dir]")
        sys.exit(1)
    
    input_path = sys.argv[1]
    output_dir = sys.argv[2] if len(sys.argv) > 2 else "memory/chat-history"
    
    # Create output directory
    Path(output_dir).mkdir(parents=True, exist_ok=True)
    
    if os.path.isdir(input_path):
        index_path = Path(input_path) / "index.json"
        count = 0
        for jsonl_file in Path(input_path).glob("*.jsonl"):
            if jsonl_to_markdown(str(jsonl_file), output_dir):
                count += 1
        print(f"Converted {count} files from {input_path}")
    else:
        jsonl_to_markdown(input_path, output_dir)

if __name__ == "__main__":
    main()
