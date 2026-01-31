# 🔄 QUICK RECONNECT GUIDE

## How to Reconnect to Your Claude Session

### Two Simple Commands:

```bash
# 1. SSH into Railway
railway ssh

# 2. Attach to your Claude session
tmux attach -t ralph
```

**That's it!** You're back in your same conversation.

---

## 📱 Save This for Quick Access

### From Your Computer

```bash
railway ssh && tmux attach -t ralph
```

**One command reconnects you!**

---

## 🔍 Check If Session Is Running

```bash
railway ssh
tmux list-sessions
```

Should show:
```
ralph: 1 windows (created Sat Feb  1 22:30:15 2026)
```

---

## 🔌 Disconnect (Keep Claude Running)

**Press:** `Ctrl+B` then `D`

You'll see: `[detached (from session ralph)]`

Claude keeps running on Railway ✅

---

## 🆘 Session Not Found?

```bash
# Start a new one
tmux new -s ralph

# Then run the loop
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

## 💾 Bookmark This Page

Save this URL pattern for quick access:
```
file:///Users/benjaminpesenti/Midnight_Code/railway-setup/RECONNECT.md
```

Or print this command and keep it handy:
```
railway ssh && tmux attach -t ralph
```

---

**Remember:** Your conversation context is preserved in the tmux session!
