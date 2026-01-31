#!/bin/bash
# Simple Railway startup script (no Docker)

echo "🚂 Railway Simple Setup Starting..."

# Install Claude Code if not already installed
if ! command -v claude &> /dev/null; then
    echo "📦 Installing Claude Code..."
    npm install -g @anthropic-ai/claude-code
fi

echo "✅ Claude Code installed: $(claude --version)"
echo ""
echo "🎯 Ready! To use Claude Code:"
echo "   1. Open Railway Terminal"
echo "   2. Run: claude auth"
echo "   3. Then: claude"
echo "   4. Start: /ralph-loop"
echo ""
echo "📍 Waiting for commands..."

# Keep container alive
tail -f /dev/null
