# Railway Claude Code Auto-Restart Setup

Complete guide for running Claude Code on Railway with automatic restart and session persistence.

## 🎯 Overview

This setup ensures Claude Code:
- ✅ Auto-restarts if it crashes or disconnects
- ✅ Survives SSH disconnections (using tmux)
- ✅ Runs with full permissions (no prompts)
- ✅ Can be reconnected from any SSH session

## 📋 Prerequisites

- Railway project with SSH access
- Claude Code CLI installed on Railway instance
- API key configured (`claude login`)

## 🚀 Setup Instructions

### Step 1: Copy Scripts to Railway

From your local machine, copy the scripts to Railway:

```bash
# Option A: Using scp (if Railway provides direct SSH)
scp run-claude-persistent.sh your-railway-instance:/app/
scp setup-claude-tmux.sh your-railway-instance:/app/

# Option B: Copy manually via Railway SSH
# SSH into Railway and create the files using the content below
```

### Step 2: SSH into Railway

```bash
# Get Railway SSH command from dashboard
railway ssh
```

### Step 3: Create the Auto-Restart Script

In Railway SSH, create `/app/run-claude-persistent.sh`:

```bash
cat > /app/run-claude-persistent.sh << 'EOF'
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
EOF

chmod +x /app/run-claude-persistent.sh
```

### Step 4: Install tmux and Start Session

```bash
# Install tmux (if not already installed)
apt-get update && apt-get install -y tmux

# Start Claude in a persistent tmux session
tmux new -s ralph -d '/app/run-claude-persistent.sh'
```

### Step 5: Verify Setup

```bash
# Check if tmux session is running
tmux list-sessions

# Attach to the session to see Claude running
tmux attach -t ralph

# Detach from session (Claude keeps running)
# Press: Ctrl+B, then D
```

## 📝 Daily Usage

### Connect to Claude

```bash
# SSH into Railway
railway ssh

# Attach to the running session
tmux attach -t ralph
```

### Disconnect (Claude Keeps Running)

While in the tmux session:
1. Press `Ctrl+B`
2. Then press `D` (detach)

Claude continues running in the background.

### Restart Claude Manually

```bash
# Kill the tmux session
tmux kill-session -t ralph

# Start fresh
tmux new -s ralph -d '/app/run-claude-persistent.sh'
```

### View Logs

```bash
# Attach to see current output
tmux attach -t ralph

# Or check Railway logs
railway logs
```

## 🔧 Troubleshooting

### Session Not Starting

```bash
# Check if tmux session exists
tmux list-sessions

# If session exists but unresponsive, kill and restart
tmux kill-session -t ralph
tmux new -s ralph -d '/app/run-claude-persistent.sh'
```

### Claude Not Auto-Restarting

```bash
# Attach to session to see error messages
tmux attach -t ralph

# Check if script is executable
ls -l /app/run-claude-persistent.sh
chmod +x /app/run-claude-persistent.sh
```

### Permission Denied Errors

```bash
# Verify Claude settings
cat ~/.claude/settings.json

# Should show:
# {
#   "permissions": {
#     "defaultMode": "bypassPermissions",
#     "allow": ["**"]
#   }
# }

# If not, recreate settings
mkdir -p ~/.claude
cat > ~/.claude/settings.json << 'SETTINGS'
{
  "permissions": {
    "defaultMode": "bypassPermissions",
    "allow": ["**"]
  }
}
SETTINGS
```

### Claude Login Expired

```bash
# Re-authenticate
claude login

# Verify authentication
claude --version
```

## 🎛️ Advanced Configuration

### Change Auto-Restart Delay

Edit `/app/run-claude-persistent.sh` and change:
```bash
sleep 10  # Change to desired seconds
```

### Add Logging

Modify the script to log to file:
```bash
# Add after the 'claude' command
claude 2>&1 | tee -a /app/claude-logs.txt
```

### Run Multiple Claude Instances

```bash
# Create sessions with different names
tmux new -s claude-1 -d '/app/run-claude-persistent.sh'
tmux new -s claude-2 -d '/app/run-claude-persistent.sh'

# Attach to specific session
tmux attach -t claude-1
```

### Set Environment Variables

Edit the script to add env vars before running Claude:
```bash
# Add before 'claude' command
export CLAUDE_API_KEY="your-key"
export WORKING_DIR="/app/project"
cd $WORKING_DIR
```

## 📊 Monitoring

### Check Session Health

```bash
# List all sessions
tmux list-sessions

# View session details
tmux list-panes -a

# Check if Claude process is running
ps aux | grep claude
```

### Watch Auto-Restarts

```bash
# Attach to session and watch restart loop
tmux attach -t ralph

# You'll see restart messages with timestamps
```

## 🔒 Security Considerations

### Bypass Permissions Mode

The script uses `"defaultMode": "bypassPermissions"` which:
- ✅ Prevents interactive permission prompts
- ⚠️  Allows all operations without confirmation
- 🔐 **Only use on trusted Railway instances**

For production, consider:
- Using more restrictive permissions
- Monitoring file changes
- Regular security audits

### API Key Security

```bash
# Verify API key is stored securely
cat ~/.claude/auth.json  # Should exist after login

# Never commit API keys to git
# Railway environment variables are secure
```

## 📚 Quick Reference

| Command | Description |
|---------|-------------|
| `tmux new -s ralph -d '/app/run-claude-persistent.sh'` | Start Claude session |
| `tmux attach -t ralph` | Connect to session |
| `Ctrl+B, D` | Detach from session |
| `tmux list-sessions` | Show all sessions |
| `tmux kill-session -t ralph` | Stop session |
| `railway ssh` | SSH into Railway |
| `railway logs` | View Railway logs |

## 🆘 Support

If issues persist:
1. Check Railway logs: `railway logs`
2. Verify Claude installation: `claude --version`
3. Test manual run: `/app/run-claude-persistent.sh` (without tmux)
4. Check system resources: `free -h` and `df -h`

## ✅ Checklist

- [ ] Scripts copied to `/app/`
- [ ] Scripts made executable (`chmod +x`)
- [ ] tmux installed
- [ ] Claude logged in (`claude login`)
- [ ] tmux session started
- [ ] Verified auto-restart works
- [ ] Tested SSH reconnection
- [ ] Bookmarked this guide

---

**Status**: Ready for production use on Railway
**Last Updated**: 2026-02-01
**Maintained By**: Midnight Team
