# 🚀 Push to GitHub - Complete Guide

## ⚠️ Issue
Git push needs authentication. We'll use a **Personal Access Token** (safe method).

---

## 📋 Step 1: Create GitHub Personal Access Token

1. **Open**: https://github.com/settings/tokens
2. Click **"Generate new token"** → **"Generate new token (classic)"**
3. **Token name**: `NSE-stock-screener`
4. **Expiration**: 90 days
5. **Scopes** - Check only: `repo` (full control of repositories)
6. Click **"Generate token"**
7. **COPY the entire token** (long string starting with `ghp_`)
8. **KEEP IT SAFE** - You'll need it in next step

---

## 📤 Step 2: Create GitHub Repository

1. Open: https://github.com/new
2. **Repository name**: `NSE-stock-screener`
3. **Visibility**: Public
4. Click **"Create repository"**

---

## 🔑 Step 3: Push Using Token

Open **Command Prompt** and run these commands:

```cmd
cd D:\Kiran\Thrissur\NSE

git remote add origin https://github.com/Kishor-Kiran/NSE-stock-screener.git

git branch -M main

git push -u origin main
```

When prompted:
```
Username for 'https://github.com': Kishor-Kiran
Password: [PASTE YOUR TOKEN HERE]
```

**IMPORTANT:**
- Username: `Kishor-Kiran`
- Password: **PASTE the token** (not your GitHub password)

---

## ✅ Success Signs

You should see:
```
Enumerating objects: 100% (100/100)
Compressing objects: 100% (80/80)
Writing objects: 100% (100/100)
...
Branch 'main' set up to track remote branch 'main' from 'origin'.
```

Then check your repo:
```
https://github.com/Kishor-Kiran/NSE-stock-screener
```

All files should be there! ✓

---

## 🆘 If That Doesn't Work

Try this one-liner with token embedded:

```cmd
git push -u https://Kishor-Kiran:YOUR_TOKEN_HERE@github.com/Kishor-Kiran/NSE-stock-screener.git main
```

Replace `YOUR_TOKEN_HERE` with your actual token.

---

## ✨ After Successful Push

You'll have:
- ✅ GitHub Repository: https://github.com/Kishor-Kiran/NSE-stock-screener
- ✅ All code backed up online
- ✅ Ready for Render deployment

---

## 🎯 Next: Deploy to Render

Once code is on GitHub, deploy to Render:
1. Go to: https://render.com/
2. Sign up with GitHub
3. New Web Service → Connect `NSE-stock-screener`
4. Deploy (3-5 minutes)
5. Get live URL: `https://nse-stock-screener-api-xxxxx.onrender.com`
