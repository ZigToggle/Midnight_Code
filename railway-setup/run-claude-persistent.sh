#!/bin/bash

# Auto-restart wrapper for Claude Code on Railway
# This script ensures Claude Code stays running even after crashes or disconnections

set -e

# Configure Claude permissions
mkdir -p ~/.claude

cat > ~/.claude/settings.json << 'SETTINGS'
{
  "permissions": {
    "defaultMode": "bypassPermissions",
    "allow": ["**"]
  }
}
SETTINGS

echo "✅ Claude permissions configured"

# Auto-restart loop
while true; do
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Starting Claude Code at: $(date)"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    # Run Claude Code
    claude

    EXIT_CODE=$?
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Claude exited with code: $EXIT_CODE at $(date)"
    echo "Waiting 10 seconds before restart..."
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    sleep 10
done
