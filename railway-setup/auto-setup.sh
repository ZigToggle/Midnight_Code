#!/bin/bash
# Fully automated Railway setup - no interaction required
# Run as root: bash auto-setup.sh

set -e

echo "🚀 Automated Railway Claude Setup"
echo "=================================="

# Clone repo if not exists
if [ ! -d "/app/Midnight_Code" ]; then
    echo "Cloning repository..."
    cd /app
    git clone https://github.com/ZigToggle/Midnight_Code.git
fi

cd /app/Midnight_Code

# Install tmux
echo "Installing tmux..."
apt-get update -qq && apt-get install -y -qq tmux

# Kill any existing sessions
tmux kill-server 2>/dev/null || true
pkill -9 claude 2>/dev/null || true

# Create claudeuser
echo "Creating claudeuser..."
id claudeuser &>/dev/null || useradd -m -s /bin/bash claudeuser

# Setup Claude directories
echo "Setting up Claude configuration..."
mkdir -p /home/claudeuser/.claude

# Save settings.json
cat > /home/claudeuser/.claude/settings.json << 'EOF'
{
  "permissions": {
    "defaultMode": "bypassPermissions",
    "allow": ["**"]
  }
}
EOF

# Save OAuth token (latest from setup-token)
echo "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" > /home/claudeuser/.claude/token

# Set ownership
chown -R claudeuser:claudeuser /app /home/claudeuser

# Configure git
echo "Configuring git..."
su - claudeuser -c 'git config --global user.email "claude-bot@peripherdev.com"'
su - claudeuser -c 'git config --global user.name "Claude Multi-Agent Bot"'

# Copy start script
cp railway-setup/start-ralph.sh /home/claudeuser/
chmod +x /home/claudeuser/start-ralph.sh
chown claudeuser:claudeuser /home/claudeuser/start-ralph.sh

echo ""
echo "✅ Setup complete!"
echo ""
echo "Starting Claude in tmux session 'ralph'..."
echo "To detach: Ctrl+B then D"
echo "To reconnect: railway ssh → su - claudeuser → tmux attach -t ralph"
echo ""

# Start tmux as claudeuser with Ralph Loop
su - claudeuser -c 'tmux new -s ralph ~/start-ralph.sh'
