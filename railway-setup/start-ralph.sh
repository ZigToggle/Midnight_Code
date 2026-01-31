#!/bin/bash
# Start Ralph Loop - Auto-restart wrapper for Claude Code
# Run as: su - claudeuser -c 'tmux new -s ralph ~/start-ralph.sh'

set -e

# Ensure we're not running as root
if [ "$(id -u)" -eq 0 ]; then
    echo "ERROR: This script must NOT run as root. Use: su - claudeuser"
    exit 1
fi

# Ensure settings.json exists with bypass permissions
mkdir -p ~/.claude
cat > ~/.claude/settings.json << 'EOF'
{
  "permissions": {
    "defaultMode": "bypassPermissions",
    "allow": ["**"]
  }
}
EOF

# Verify token exists
if [ ! -f ~/.claude/token ]; then
    echo "ERROR: Token file not found at ~/.claude/token"
    echo "Run: claude setup-token first"
    exit 1
fi

# Configure git
git config --global user.email "claude-bot@peripherdev.com" 2>/dev/null || true
git config --global user.name "Claude Multi-Agent Bot" 2>/dev/null || true

# Set working directory
cd /app/Midnight_Code || cd /app

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🤖 Ralph Loop - Autonomous Claude Code Execution"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "User: $(whoami)"
echo "Working Dir: $(pwd)"
echo "Token: $([ -f ~/.claude/token ] && echo '✓ Found' || echo '✗ Missing')"
echo "Settings: $([ -f ~/.claude/settings.json ] && echo '✓ Found' || echo '✗ Missing')"
echo ""
echo "To detach: Ctrl+B then D"
echo "To reconnect: railway ssh → su - claudeuser → tmux attach -t ralph"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Auto-restart loop
RESTART_COUNT=0
while true; do
    echo ""
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 🚀 Starting Claude Code (Attempt #$((RESTART_COUNT + 1)))..."

    # Start Claude Code (no flags - settings.json handles permissions)
    claude

    EXIT_CODE=$?
    RESTART_COUNT=$((RESTART_COUNT + 1))

    echo ""
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ⚠️  Claude exited with code: $EXIT_CODE"

    # If exit code indicates permission issues, abort
    if [ $EXIT_CODE -eq 1 ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ⚠️  Error detected. Checking if recoverable..."

        # Too many rapid restarts might indicate a config issue
        if [ $RESTART_COUNT -gt 5 ]; then
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] ❌ Too many failures. Stopping auto-restart."
            echo "Check settings.json and token file, then restart manually."
            exit 1
        fi
    fi

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 🔄 Restarting in 10 seconds..."
    sleep 10
done
