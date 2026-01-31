#!/bin/bash
# Daemon script to run Claude in the background without needing interactive tmux

set -e

# Must run as claudeuser
if [ "$(whoami)" != "claudeuser" ]; then
    echo "ERROR: Must run as claudeuser"
    exit 1
fi

# Ensure directories exist
mkdir -p ~/.claude
cd /app/Midnight_Code

# Log file
LOG_FILE=~/claude-output.log

echo "🚀 Starting Claude Code daemon..." | tee -a $LOG_FILE
echo "Log file: $LOG_FILE" | tee -a $LOG_FILE
echo "" | tee -a $LOG_FILE

# Run Claude with auto-restart in background
while true; do
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting Claude..." | tee -a $LOG_FILE

    # Run Claude and capture output
    claude 2>&1 | tee -a $LOG_FILE

    EXIT_CODE=${PIPESTATUS[0]}
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Claude exited with code: $EXIT_CODE" | tee -a $LOG_FILE

    if [ $EXIT_CODE -ne 0 ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Error - restarting in 10s..." | tee -a $LOG_FILE
    fi

    sleep 10
done
