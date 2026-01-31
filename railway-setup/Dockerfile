# Dockerfile for running Claude Code on Railway
FROM node:20-bullseye

# Set working directory
WORKDIR /app

# Install system dependencies in one layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
    gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
    tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
    apt-get update && \
    apt-get install -y gh && \
    rm -rf /var/lib/apt/lists/*

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code

# Create startup script inline (avoids COPY path issues)
RUN echo '#!/bin/bash\n\
echo "🚂 Railway Claude Code Server Starting..."\n\
\n\
if [ ! -d "/app/Midnight_Code" ]; then\n\
    echo "📦 Cloning repository..."\n\
    git clone https://github.com/${GITHUB_ORG:-ZigToggle}/${GITHUB_REPO:-Midnight_Code}.git /app/Midnight_Code\n\
    cd /app/Midnight_Code\n\
else\n\
    echo "✅ Repository already cloned"\n\
    cd /app/Midnight_Code\n\
    git pull origin main\n\
fi\n\
\n\
git config --global user.email "${GIT_EMAIL:-claude-bot@railway.app}"\n\
git config --global user.name "${GIT_NAME:-Claude Code Bot}"\n\
\n\
echo "✅ Setup complete!"\n\
echo ""\n\
echo "🤖 To start Claude Code:"\n\
echo "   1. Connect: railway shell"\n\
echo "   2. Configure git: git config --global user.email ..."\n\
echo "   3. Auth GitHub: gh auth login"\n\
echo "   4. Start Claude: claude"\n\
echo "   5. Start Ralph: /ralph-loop"\n\
echo ""\n\
echo "⚙️  ANTHROPIC_API_KEY: ${ANTHROPIC_API_KEY:+✓ Set}${ANTHROPIC_API_KEY:-✗ Not set - add in Railway Variables}"\n\
echo ""\n\
echo "📍 Current directory: $(pwd)"\n\
echo "📁 Repository ready at: /app/Midnight_Code"\n\
echo ""\n\
\n\
tail -f /dev/null' > /app/start.sh && chmod +x /app/start.sh

# Expose port (Railway requirement)
EXPOSE 8080

# Default command (runs startup script)
CMD ["/bin/bash", "/app/start.sh"]
