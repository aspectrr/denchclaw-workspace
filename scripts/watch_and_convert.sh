#!/bin/bash
# Watch web-chat directory and convert new/updated JSONL files to markdown

WATCH_DIR="/Users/collinpfeifer/.openclaw-dench/workspace/.openclaw/web-chat"
OUTPUT_DIR="/Users/collinpfeifer/.openclaw-dench/workspace/memory/chat-history"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$OUTPUT_DIR"

echo "Watching $WATCH_DIR for changes..."

# Convert existing files on start
python3 "$SCRIPT_DIR/convert_chats.py" "$WATCH_DIR" "$OUTPUT_DIR"

# Watch for changes (created or modified)
fswatch -r "$WATCH_DIR" \
    --exclude='\.json$' \
    --exclude='index\.json' \
    --event=Created \
    --event=Updated \
    -o | while read -r events; do
    # Run conversion on any jsonl file change
    find "$WATCH_DIR" -name "*.jsonl" -newer "$OUTPUT_DIR/.last_run" 2>/dev/null | while read -r file; do
        python3 "$SCRIPT_DIR/convert_chats.py" "$file" "$OUTPUT_DIR"
    done
    touch "$OUTPUT_DIR/.last_run"
done
