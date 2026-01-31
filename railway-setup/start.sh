#!/bin/bash
# Railway startup script for Claude Code autonomous translation

echo "🚂 Railway Claude Code Server Starting..."

# Clone the repository if not already present
if [ ! -d "/app/Midnight_Code" ]; then
    echo "📦 Cloning repository..."
    git clone https://github.com/${GITHUB_ORG}/${GITHUB_REPO}.git /app/Midnight_Code
    cd /app/Midnight_Code
else
    echo "✅ Repository already cloned"
    cd /app/Midnight_Code
    git pull origin main
fi

# Configure git
git config --global user.email "${GIT_EMAIL:-claude-bot@railway.app}"
git config --global user.name "${GIT_NAME:-Claude Code Bot}"

echo "✅ Setup complete!"
echo ""
echo "🤖 To start Claude Code:"
echo "   1. Connect to this Railway service via CLI: railway shell"
echo "   2. Run: claude"
echo "   3. Start autonomous mode: /ralph-loop"
echo ""
echo "📍 Current directory: $(pwd)"
echo "📁 Files: $(ls -la)"
echo ""

# Keep container alive
tail -f /dev/null
