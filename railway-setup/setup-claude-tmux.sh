#!/bin/bash
set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚂 Railway Claude Code Setup with Auto-Reconnect"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Kill existing tmux sessions
echo "1. Cleaning up old sessions..."
tmux kill-server 2>/dev/null || true
pkill -9 claude 2>/dev/null || true

# Create claudeuser if doesn't exist
echo "2. Setting up claudeuser..."
id claudeuser &>/dev/null || useradd -m -s /bin/bash claudeuser

# Create Claude settings for claudeuser
echo "3. Configuring Claude permissions..."
mkdir -p /home/claudeuser/.claude
cat > /home/claudeuser/.claude/settings.json << 'EOF'
{
  "permissions": {
    "defaultMode": "bypassPermissions",
    "allow": ["**"]
  }
}
EOF

# Give ownership of /app to claudeuser
echo "4. Setting permissions..."
chown -R claudeuser:claudeuser /app /home/claudeuser

# Configure git for claudeuser
echo "5. Configuring git..."
su - claudeuser -c 'git config --global user.email "claude-bot@peripherdev.com"'
su - claudeuser -c 'git config --global user.name "Claude Multi-Agent Bot"'

# Create persistent Claude script
echo "6. Creating auto-restart script..."
cat > /home/claudeuser/run-claude-persistent.sh << 'INNERSCRIPT'
#!/bin/bash

# Ensure settings exist
mkdir -p ~/.claude
cat > ~/.claude/settings.json << 'SETTINGS'
{
  "permissions": {
    "defaultMode": "bypassPermissions",
    "allow": ["**"]
  }
}
SETTINGS

# Configure git
git config --global user.email "claude-bot@peripherdev.com"
git config --global user.name "Claude Multi-Agent Bot"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Claude Code Auto-Restart Service"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "To reconnect: railway ssh → su - claudeuser → tmux attach -t ralph"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Loop: restart Claude if it crashes
while true; do
    echo ""
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 🚀 Starting Claude Code..."

    cd /app
    claude

    EXIT_CODE=$?
    echo ""
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ⚠️  Claude exited with code: $EXIT_CODE"

    if [ $EXIT_CODE -ne 0 ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] 🔄 Error detected. Restarting in 10 seconds..."
    else
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ✅ Clean exit. Restarting in 10 seconds..."
    fi

    sleep 10
done
INNERSCRIPT

chmod +x /home/claudeuser/run-claude-persistent.sh
chown claudeuser:claudeuser /home/claudeuser/run-claude-persistent.sh

# Install tmux if not present
echo "7. Installing tmux..."
which tmux &>/dev/null || (apt-get update && apt-get install -y tmux)

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Setup Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Now starting tmux session as claudeuser..."
echo ""
echo "Commands to know:"
echo "  - Detach from tmux: Ctrl+B, then D"
echo "  - Reconnect: railway ssh → su - claudeuser → tmux attach -t ralph"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Start tmux session as claudeuser
su - claudeuser -c 'tmux new -s ralph /home/claudeuser/run-claude-persistent.sh'
