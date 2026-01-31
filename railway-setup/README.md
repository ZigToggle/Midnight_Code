# Claude Code on Railway - Setup Guide

Deploy Claude Code to Railway for 24/7 autonomous iOS → Android translation.

## 🚀 Quick Deploy (5 minutes)

### Step 1: Install Railway CLI

```bash
# macOS
brew install railway

# Or via npm
npm install -g @railway/cli
```

### Step 2: Login to Railway

```bash
railway login
# Opens browser to authenticate
```

### Step 3: Deploy This Project

```bash
cd /Users/benjaminpesenti/Midnight_Code/railway-setup

# Initialize Railway project
railway init

# Give it a name: "claude-code-android-translation"

# Deploy
railway up
```

### Step 4: Set Environment Variables

```bash
# Set required environment variables
railway variables set GITHUB_ORG=your-org-name
railway variables set GITHUB_REPO=Midnight_Code
railway variables set GIT_EMAIL=your-email@example.com
railway variables set GIT_NAME="Your Name"

# Set Anthropic API key (for Claude Code authentication)
railway variables set ANTHROPIC_API_KEY=your-api-key
```

### Step 5: Connect to Running Service

```bash
# Open a shell in the Railway container
railway shell

# Once inside:
claude auth
# Authenticate with your Anthropic account

# Start the autonomous translation
claude
# Then type: /ralph-loop
```

---

## 🎯 Alternative: Deploy with GitHub Integration

### Option A: Via Railway Dashboard (Easiest)

1. Go to: https://railway.app/new
2. Click "Deploy from GitHub repo"
3. Select this repository
4. Point to `/railway-setup/` directory
5. Set environment variables in dashboard
6. Deploy!
7. Use "Open Terminal" in Railway dashboard to access Claude Code

### Option B: One-Click Deploy Button

Add this to your repository README:

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template?template=https://github.com/YOUR_ORG/Midnight_Code&envs=GITHUB_ORG,GITHUB_REPO,GIT_EMAIL,GIT_NAME)

---

## 📊 Cost Estimate

Railway Pricing:
- **Free tier**: $5 credit/month (~100 hours of runtime)
- **After free tier**: ~$5-10/month for basic service
- **For this project**: Estimated $10-15 for full iOS → Android translation (7 days)

---

## 🔧 Accessing Your Running Service

### Method 1: Railway CLI

```bash
# From your local machine
railway shell

# Now you're inside the container!
cd /app/Midnight_Code
claude
```

### Method 2: Railway Dashboard

1. Go to: https://railway.app/dashboard
2. Click on your "claude-code-android-translation" service
3. Click "Terminal" tab
4. Type: `claude`

### Method 3: SSH (Advanced)

```bash
# Get the SSH command from Railway dashboard
railway ssh
```

---

## 📝 Full Autonomous Workflow

Once connected to your Railway service:

```bash
# 1. Navigate to project
cd /app/Midnight_Code

# 2. Start Claude Code
claude

# 3. Start Ralph Loop
/ralph-loop

# 4. Give it the full task:
```

**Task prompt:**

```
iOS to Android Translation - Railway Autonomous Execution

SOURCE: /app/Midnight_Code/ios/Midnight/
TARGET: /app/Midnight_Code/android/

FULL AUTONOMOUS MODE:
1. Analyze iOS codebase (200+ Swift files)
2. Create Android project structure (Kotlin + Gradle + Jetpack Compose)
3. Translate in this order:
   - Config & Constants
   - Core: APIClient, TokenStorage, AuthService
   - Services: AgoraService, SocketService, RealtimeService, etc.
   - ViewModels: All MVVM ViewModels
   - Views: SwiftUI → Jetpack Compose
   - Utils & Extensions

4. For each component:
   - Translate Swift → Kotlin (idiomatic Android patterns)
   - Maintain same architecture
   - Add unit tests
   - Run tests
   - Git commit

5. Work continuously for 7 days
6. Only create Linear issues for blocking decisions
7. Git push every 10 commits

PLATFORM MAPPINGS:
- SwiftUI → Jetpack Compose
- Keychain → EncryptedSharedPreferences
- UserDefaults → DataStore (Preferences)
- CallKit → ConnectionService
- VoIP Push → FCM high-priority data messages
- URLSession → Retrofit2 + OkHttp
- Combine → Kotlin Coroutines + Flow
- NotificationCenter → LiveData / SharedFlow

SUCCESS CRITERIA:
- Android app builds successfully (./gradlew build)
- Core functionality working (auth, video calls, payments)
- Unit tests passing
- Follows Kotlin/Android best practices
- Git history shows progress

EXECUTE AUTONOMOUSLY. BEGIN NOW.
```

---

## 🔍 Monitoring Progress (While Your Laptop is Closed)

### Option 1: Check Git Commits

```bash
# From any device with git:
git log --oneline --graph --all

# Or check on GitHub:
# https://github.com/YOUR_ORG/Midnight_Code/commits/main
```

### Option 2: Railway Logs

```bash
# From local terminal:
railway logs

# Or check logs in Railway dashboard:
# https://railway.app/dashboard → Your Service → Logs
```

### Option 3: Reconnect Anytime

```bash
# Your laptop at home, work, anywhere:
railway shell
# Check progress, view files, monitor Claude Code
```

---

## ⚡ Pro Tips

### Keep Service Running Forever

Railway services stay running as long as they have a process. The Dockerfile uses `tail -f /dev/null` to keep it alive indefinitely.

### Auto-Push to GitHub

Inside the Railway shell, set up auto-push:

```bash
# Cron job to push every hour
(crontab -l 2>/dev/null; echo "0 * * * * cd /app/Midnight_Code && git push origin main") | crontab -
```

### Get Notifications

Set up GitHub Actions to notify you on new commits:

```yaml
# .github/workflows/notify.yml
name: Notify on Commit
on: [push]
jobs:
  notify:
    runs-on: ubuntu-latest
    steps:
      - name: Send notification
        run: |
          curl -X POST https://api.telegram.org/bot<YOUR_BOT_TOKEN>/sendMessage \
            -d chat_id=<YOUR_CHAT_ID> \
            -d text="New commit: ${{ github.event.head_commit.message }}"
```

---

## 🛠 Troubleshooting

### Issue: "Railway deployment failed"

**Fix:**
```bash
# Check logs
railway logs

# Common issue: wrong directory
# Make sure you're in /railway-setup/ when running `railway up`
```

### Issue: "Claude Code not authenticated"

**Fix:**
```bash
railway shell
claude auth
# Follow the browser authentication flow
```

### Issue: "Can't push to GitHub"

**Fix:**
```bash
railway shell

# Set up GitHub credentials
gh auth login
# Or use personal access token:
git config --global credential.helper store
echo "https://YOUR_USERNAME:YOUR_GITHUB_TOKEN@github.com" > ~/.git-credentials
```

---

## 📞 Need Help?

- Railway Docs: https://docs.railway.app
- Railway Discord: https://discord.gg/railway
- Claude Code Docs: https://claude.ai/code

---

## ✅ Success Checklist

- [ ] Railway CLI installed
- [ ] Logged into Railway (`railway login`)
- [ ] Project deployed (`railway up`)
- [ ] Environment variables set
- [ ] Connected to service (`railway shell`)
- [ ] Claude Code authenticated
- [ ] Ralph Loop started with iOS → Android task
- [ ] Laptop closed, task running! 🎉
