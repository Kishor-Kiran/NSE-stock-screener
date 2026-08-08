# 🚀 Deploy NSE Stock Screener to GitHub & Render (Live URL)

## ✅ Pre-requisites Done
- ✓ Git configured with email: kingskiran8@gmail.com
- ✓ NSE project folder structured
- ✓ Initial commit created
- ✓ All files ready

---

## 📋 STEP 1: Create GitHub Repository

### Quick Steps:

1. **Open**: https://github.com/new
2. **Fill in**:
   - **Repository name**: `NSE-stock-screener`
   - **Description**: `Real-time NSE and NYSE Stock Screener - Full Stack Application`
   - **Public**: ✓ (checked)
   - **Initialize**: Leave unchecked
3. **Click**: "Create repository"

**Keep this page open!** You'll see commands to run.

---

## 📤 STEP 2: Push to GitHub

After creating the repo on GitHub, you'll see a page showing commands. Run these in Command Prompt:

```cmd
cd D:\Kiran\Thrissur\NSE

git remote add origin https://github.com/YOUR_GITHUB_USERNAME/NSE-stock-screener.git

git branch -M main

git push -u origin main
```

**Replace `YOUR_GITHUB_USERNAME` with your actual GitHub username**

### When It Asks for Credentials:

**Option A: GitHub Password (Easy)**
- Username: Your GitHub username
- Password: Your GitHub password

**Option B: Personal Access Token (Recommended)**
1. Go to: https://github.com/settings/tokens
2. Click "Generate new token" → "Generate new token (classic)"
3. **Token name**: `nse-stock-screener`
4. **Expiration**: 90 days
5. **Select scopes**: Check `repo` (full control)
6. Click "Generate token"
7. Copy the token
8. Use as password in git push

---

## ✅ Step 2 Complete When:
You see:
```
✓ Branch 'main' set up to track remote branch 'main' from 'origin'.
```

Your GitHub repo is now: **https://github.com/YOUR_USERNAME/NSE-stock-screener**

---

## 🌐 STEP 3: Deploy to Render (Get Live URL)

### 3.1 Create Render Account

1. Go to: https://render.com/
2. Click "Sign up with GitHub"
3. Authorize Render
4. **You have a Render account!**

### 3.2 Deploy Backend API

1. Go to Render Dashboard: https://dashboard.render.com/
2. Click **"New +"** → **"Web Service"**
3. Click **"Connect a repository"**
4. **Find & Select**: `NSE-stock-screener`
5. Click **"Connect"**

### 3.3 Configure Service

Fill in these fields:

| Field | Value |
|-------|-------|
| **Name** | `nse-stock-screener-api` |
| **Environment** | `Python 3` |
| **Build Command** | `pip install -r backend/requirements-prod.txt` |
| **Start Command** | `cd backend && gunicorn app_demo:app --bind 0.0.0.0:$PORT` |
| **Plan** | `Free` |

**Click**: "Create Web Service"

### ⏳ Wait 3-5 minutes...

Once you see:
```
✓ Build successful
✓ Live
```

Your **live API URL** appears at the top! 🎉

**Example**: `https://nse-stock-screener-api-xxxxx.onrender.com`

---

## ✅ Test Your Live API

Open your browser and test:

```
https://nse-stock-screener-api-xxxxx.onrender.com/api/health
```

You should see:
```json
{"status": "healthy"}
```

**Your backend is live!** ✅

---

## 🎨 STEP 4: Deploy Frontend (Optional but Recommended)

### For Full Web App (with Visual UI)

### 4.1 Sign Up for Vercel

1. Go to: https://vercel.com/
2. Click "Sign up with GitHub"
3. Authorize Vercel

### 4.2 Deploy Frontend

1. In Vercel Dashboard, click **"Add New"** → **"Project"**
2. **Select repo**: `NSE-stock-screener`
3. **Framework**: React
4. **Build Command**: 
   ```
   cd frontend && npm run build
   ```
5. **Output Directory**: 
   ```
   frontend/build
   ```
6. Click **"Environment Variables"**
7. Add new variable:
   - **Name**: `REACT_APP_API_URL`
   - **Value**: `https://nse-stock-screener-api-xxxxx.onrender.com`
     *(Use your actual Render URL from Step 3)*
8. Click **"Deploy"**

### ⏳ Wait 2-3 minutes...

Your **frontend URL** appears! 🎉

**Example**: `https://nse-stock-screener-kingskiran.vercel.app`

---

## 🎯 YOUR LIVE URLS

### Backend API (Always Available)
```
https://nse-stock-screener-api-xxxxx.onrender.com
```

**Test these endpoints**:
```
https://nse-stock-screener-api-xxxxx.onrender.com/api/stocks/nse
https://nse-stock-screener-api-xxxxx.onrender.com/api/stocks/nyse
https://nse-stock-screener-api-xxxxx.onrender.com/api/health
```

### Frontend UI (Visual Interface)
```
https://nse-stock-screener-kingskiran.vercel.app
```

**Open this in browser to see the Stock Screener UI!**

---

## 📊 Sample API Response

```bash
curl https://nse-stock-screener-api-xxxxx.onrender.com/api/stocks/nse
```

Response:
```json
{
  "market": "NSE",
  "count": 10,
  "cached": false,
  "stocks": [
    {
      "ticker": "MARUTI.NS",
      "current_price": 11850.75,
      "pe_ratio": 14.5,
      "volume_ratio": 3.05,
      "rsi": 72.3,
      "rank_score": 220.5
    },
    ... (9 more stocks)
  ]
}
```

---

## ✅ Deployment Checklist

```
Step 1 - GitHub:
☐ Repository created on GitHub
☐ Code pushed to GitHub
☐ Can see files at: https://github.com/YOUR_USERNAME/NSE-stock-screener

Step 2 - Render Backend:
☐ Render account created
☐ Web Service created
☐ Build successful
☐ Service is "Live"
☐ API responding at /api/health
☐ Live URL: https://nse-stock-screener-api-xxxxx.onrender.com

Step 3 - Vercel Frontend (Optional):
☐ Vercel account created
☐ Project connected
☐ Build successful
☐ Environment variable set
☐ Live URL: https://nse-stock-screener-kingskiran.vercel.app

Testing:
☐ Backend API test passed
☐ Frontend UI loads
☐ NSE stocks displaying
☐ NYSE stocks working
☐ Market toggle functional
☐ Cache indicator showing
```

---

## 🆘 Troubleshooting

### GitHub Push Fails
- Check git config: `git config --list`
- Verify credentials are correct
- Use Personal Access Token instead of password
- Try: `git push -u origin main` again

### Render Build Fails
- Check build logs in Render dashboard
- Verify `requirements-prod.txt` has all dependencies
- Check `Procfile` syntax
- Ensure backend path is correct

### Frontend Can't Connect
- Verify `REACT_APP_API_URL` is set in Vercel
- Check Render URL is correct (copy from Render dashboard)
- Wait for Render service to finish cold start (first request takes 10-30s)

### Service Takes Time to Respond
- Free tier has cold starts (spinning up takes time)
- First request may take 20-30 seconds
- Subsequent requests are fast
- To avoid cold start: Upgrade to Render Starter ($7/month)

---

## 📈 Performance Notes

| Aspect | Free Tier | Notes |
|--------|-----------|-------|
| **Uptime** | Good | Services spin down after 15 min idle |
| **Response Time** | Fast (cached) | First request ~10-30s, cached <100ms |
| **Data Limit** | Unlimited | Using demo data for now |
| **Scaling** | Manual | Need manual restart for updates |

---

## 🔄 After Deployment

### Update Your App
```bash
cd D:\Kiran\Thrissur\NSE

# Make changes locally

git add .
git commit -m "Update description"
git push origin main

# Render auto-redeploys!
```

### Monitor Live App
- Render Dashboard: https://dashboard.render.com/
- Vercel Dashboard: https://vercel.com/dashboard
- Check logs for errors
- Set up alerts for failures

---

## 🎓 Quick Reference

### Your Repositories
- **GitHub**: https://github.com/YOUR_USERNAME/NSE-stock-screener
- **Render**: https://nse-stock-screener-api-xxxxx.onrender.com
- **Vercel**: https://nse-stock-screener-kingskiran.vercel.app

### Useful Commands
```bash
# Check git status
git status

# View git log
git log --oneline

# Make a change and push
git add .
git commit -m "Your message"
git push origin main
```

### Support Links
- Render: https://render.com/docs
- Vercel: https://vercel.com/docs
- GitHub: https://docs.github.com

---

## 🎉 Congratulations!

Your NSE Stock Screener is now:
- ✅ On GitHub (backed up + shareable)
- ✅ Live on Render (API accessible globally)
- ✅ Live on Vercel (UI accessible globally)
- ✅ Accessible from anywhere in the world

**Share your URLs with anyone!** 🚀

---

**Questions? Check the logs in each platform's dashboard.**
