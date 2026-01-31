# Simple Railway Claude Setup - "Ralph Loop"

## 🎯 What This Does

Creates a persistent Claude session that:
- ✅ Stays running even when you close your terminal
- ✅ Keeps your **SAME conversation context** when you reconnect
- ✅ Auto-restarts Claude if it crashes
- ✅ You can reconnect anytime from anywhere

---

## 🚀 ONE-TIME SETUP (Run Once on Railway)

SSH into Railway and run these 3 commands:

```bash
# 1. Install tmux
apt-get update && apt-get install -y tmux

# 2. Configure Claude to bypass all permissions
mkdir -p ~/.claude && cat > ~/.claude/settings.json << 'EOF'
{
  "permissions": {
    "defaultMode": "bypassPermissions",
    "allow": ["**"]
  }
}
EOF

# 3. Start tmux session "ralph" with auto-restart loop
tmux new -s ralph
```

When tmux starts, you'll see a new shell. Now run:

```bash
# Inside the tmux session, start the Ralph Loop
while true; do
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Starting Claude at: $(date)"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    claude
    echo "Claude exited. Restarting in 10 seconds..."
    sleep 10
done
```

**Claude will now start and you'll see the Claude Code interface.**

---

## 🔌 HOW TO DISCONNECT (Without Stopping Claude)

When you want to close your terminal but keep Claude running:

**Press:** `Ctrl+B` then `D`

This **detaches** from the tmux session. Claude keeps running on the server.

You'll see a message like:
```
[detached (from session ralph)]
```

Now you can safely close your terminal. Claude is still running on Railway!

---

## 🔄 HOW TO RECONNECT (IMPORTANT!)

### Step 1: SSH Back into Railway

```bash
railway ssh
```

### Step 2: Reconnect to Your Claude Session

```bash
tmux attach -t ralph
```

**That's it!** You'll be back in your **SAME Claude conversation** with all context preserved.

---

## 📋 Common Scenarios

### Scenario 1: You Closed Your Terminal

```bash
# From your computer
railway ssh

# Reconnect to Ralph
tmux attach -t ralph

# ✅ You're back in the same conversation!
```

### Scenario 2: Check If Claude Is Still Running

```bash
# SSH into Railway
railway ssh

# List tmux sessions
tmux list-sessions

# You should see:
# ralph: 1 windows (created Sat Feb  1 22:30:15 2026)
```

### Scenario 3: Claude Crashed But Auto-Restarted

```bash
# Reconnect as normal
railway ssh
tmux attach -t ralph

# You'll see the restart messages:
# "Claude exited. Restarting in 10 seconds..."
# "Starting Claude at: [timestamp]"

# Then you're back in Claude!
```

### Scenario 4: Start Fresh (Kill and Restart)

```bash
# SSH into Railway
railway ssh

# Kill the old session
tmux kill-session -t ralph

# Start a new one
tmux new -s ralph

# Run the loop again
while true; do
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Starting Claude at: $(date)"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    claude
    echo "Claude exited. Restarting in 10 seconds..."
    sleep 10
done
```

---

## 🎯 Key Commands Cheat Sheet

| Action | Command |
|--------|---------|
| **SSH into Railway** | `railway ssh` |
| **Reconnect to Claude** | `tmux attach -t ralph` |
| **Disconnect (keep running)** | `Ctrl+B` then `D` |
| **List sessions** | `tmux list-sessions` |
| **Kill session** | `tmux kill-session -t ralph` |
| **Start new session** | `tmux new -s ralph` |

---

## 💡 Important Notes

### Context Preservation

When you reconnect to the tmux session:
- ✅ Your **conversation history is preserved**
- ✅ Claude remembers what you were working on
- ✅ All files you had open are still accessible
- ✅ It's like you never left!

### Auto-Restart Behavior

If Claude crashes:
1. The loop waits 10 seconds
2. Automatically restarts Claude
3. You start with a fresh Claude session
4. **Previous conversation context is lost** (this is a crash recovery)

To keep context across crashes, always **detach** properly with `Ctrl+B` then `D`.

### Multiple Reconnections

You can disconnect and reconnect as many times as you want:
```bash
# Morning
railway ssh
tmux attach -t ralph
# Work on something...
# Ctrl+B, D to disconnect

# Afternoon (from different computer)
railway ssh
tmux attach -t ralph
# Continue where you left off!

# Evening
railway ssh
tmux attach -t ralph
# Same conversation still there!
```

---

## 🆘 Troubleshooting

### Can't Reconnect - Session Not Found

```bash
# Check if session exists
tmux list-sessions

# If empty, the session died. Start a new one:
tmux new -s ralph
# Then run the while loop
```

### Already Attached Error

```bash
# If you get "sessions should be nested with care"
# You're already in a tmux session. Exit first:
exit

# Then attach
tmux attach -t ralph
```

### Multiple Sessions Confusing

```bash
# Kill all sessions and start fresh
tmux kill-server

# Start clean
tmux new -s ralph
```

---

## ✅ Success Checklist

- [ ] tmux installed on Railway
- [ ] Claude permissions configured
- [ ] tmux session "ralph" started
- [ ] Claude running in the loop
- [ ] Successfully detached with `Ctrl+B` then `D`
- [ ] Successfully reconnected with `tmux attach -t ralph`
- [ ] Bookmarked this guide for future reference

---

## 🎓 Understanding tmux

Think of tmux like a **persistent window** on the server:

```
Your Computer          Railway Server
    |                       |
    |------- SSH --------->|
    |                   [tmux: ralph]
    |                   [Claude running]
    |                       |
  Close                     |
 Terminal                   |
    |                   [tmux: ralph] ← Still running!
    |                   [Claude running]
    |                       |
    |------- SSH --------->|
    |                       |
  Reconnect            [tmux: ralph]
    |---------------->[Same Claude session!]
```

---

**You're all set!** Just remember the reconnect command:

```bash
railway ssh
tmux attach -t ralph
```

Save this guide and you'll never lose your Claude context again! 🎉
