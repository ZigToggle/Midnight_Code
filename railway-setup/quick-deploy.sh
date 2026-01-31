#!/bin/bash

# Quick deployment script for Railway Claude Code setup
# Run this from your LOCAL machine to deploy to Railway

set -e

echo "🚀 Railway Claude Code Quick Deploy"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if we're in the railway-setup directory
if [ ! -f "run-claude-persistent.sh" ]; then
    echo "❌ Error: run-claude-persistent.sh not found"
    echo "Please run this script from the railway-setup directory"
    exit 1
fi

echo "📋 This script will:"
echo "  1. Show you the commands to copy to Railway"
echo "  2. Provide step-by-step instructions"
echo ""
echo "Press Enter to continue..."
read

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "STEP 1: SSH into Railway"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Run this command in a NEW terminal:"
echo ""
echo "  railway ssh"
echo ""
echo "Press Enter when connected to Railway..."
read

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "STEP 2: Create Auto-Restart Script"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Copy and paste this ENTIRE block into your Railway SSH session:"
echo ""
cat << 'SCRIPT'
cat > /app/run-claude-persistent.sh << 'EOF'
#!/bin/bash
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

    claude

    EXIT_CODE=$?
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Claude exited with code: $EXIT_CODE at $(date)"
    echo "Waiting 10 seconds before restart..."
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    sleep 10
done
EOF

chmod +x /app/run-claude-persistent.sh
echo "✅ Script created and made executable"
SCRIPT
echo ""
echo "Press Enter when done..."
read

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "STEP 3: Install tmux and Start Claude"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Copy and paste these commands into Railway SSH:"
echo ""
cat << 'COMMANDS'
# Install tmux
apt-get update && apt-get install -y tmux

# Start Claude in tmux session
tmux new -s ralph -d '/app/run-claude-persistent.sh'

# Verify it's running
tmux list-sessions

echo ""
echo "✅ Claude Code is now running!"
echo "To attach: tmux attach -t ralph"
echo "To detach: Ctrl+B then D"
COMMANDS
echo ""
echo "Press Enter when done..."
read

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ SETUP COMPLETE!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 What's now running:"
echo "  ✅ Claude Code in tmux session 'ralph'"
echo "  ✅ Auto-restart if Claude crashes"
echo "  ✅ Survives SSH disconnections"
echo ""
echo "📚 Common commands:"
echo "  • Attach to session:   tmux attach -t ralph"
echo "  • Detach from session: Ctrl+B then D"
echo "  • Kill session:        tmux kill-session -t ralph"
echo "  • List sessions:       tmux list-sessions"
echo ""
echo "📖 Full documentation: RAILWAY-CLAUDE-SETUP.md"
echo ""
