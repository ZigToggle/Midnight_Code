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
echo "🚂 Railway Claude Code - Auto Setup Starting..."\n\
\n\
# Clone or update repo\n\
if [ ! -d "/app/Midnight_Code" ]; then\n\
    echo "📦 Cloning repository..."\n\
    git clone https://github.com/${GITHUB_ORG:-ZigToggle}/${GITHUB_REPO:-Midnight_Code}.git /app/Midnight_Code\n\
else\n\
    echo "📦 Updating repository..."\n\
    cd /app/Midnight_Code && git pull origin main\n\
fi\n\
\n\
cd /app/Midnight_Code\n\
\n\
echo "🚀 Running automated setup..."\n\
bash railway-setup/auto-setup.sh\n\
' > /app/start.sh && chmod +x /app/start.sh

# Expose port (Railway requirement)
EXPOSE 8080

# Default command (runs startup script)
CMD ["/bin/bash", "/app/start.sh"]
