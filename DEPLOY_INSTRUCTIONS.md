# 🚀 Stock Screener - Deployment Instructions

## Quick Summary

Your Stock Screener is ready for public deployment! Here's how to get it live on the internet.

---

## 📋 What You Need (5 minutes to set up)

1. **GitHub Account** (free): https://github.com/signup
2. **Render Account** (free): https://render.com/
3. **Git installed**: Already available on your system

---

## 🎯 Three Simple Steps

### Step 1: Push to GitHub (5 minutes)

```bash
# Open command prompt in your project directory
cd D:\Kiran\Thrissur\TCEDERP

# Initialize git
git init
git add .
git commit -m "Stock Screener - Full Stack App"

# Create a new repository on https://github.com/new
# Then run:
git remote add origin https://github.com/YOUR_USERNAME/stock-screener.git
git branch -M main
git push -u origin main
```

**Replace `YOUR_USERNAME` with your GitHub username**

### Step 2: Deploy Backend on Render (5 minutes)

1. Go to https://render.com/
2. Sign up (free)
3. Dashboard → "New +" → "Web Service"
4. "Connect a repository" → Find `stock-screener`
5. Fill in:
   - **Name**: `stock-screener-api`
   - **Build Command**: `pip install -r backend/requirements-prod.txt`
   - **Start Command**: `cd backend && gunicorn app_demo:app --bind 0.0.0.0:$PORT`
   - **Plan**: Free
6. Click "Create Web Service"

**Wait 3-5 minutes for deployment** ✅

### Step 3: Get Your Public URL

Once deployed, Render will give you a URL like:
```
https://stock-screener-api.onrender.com
```

---

## ✅ Test It Works

Open your browser and test:

```
https://stock-screener-api.onrender.com/api/health
```

You should see:
```json
{"status": "healthy"}
```

---

## 🎨 Optional: Deploy Frontend Too

If you want a public web interface (not just API):

### Deploy to Vercel (Recommended, Free)

1. Go to https://vercel.com/
2. Sign in with GitHub
3. "New Project" → Select `stock-screener` repo
4. **Framework**: React
5. **Build Command**: `cd frontend && npm run build`
6. **Output Directory**: `frontend/build`
7. **Environment Variables** → Add:
   ```
   REACT_APP_API_URL = https://stock-screener-api.onrender.com
   ```
8. Click "Deploy"

**Wait 2-3 minutes** ✅

You'll get a URL like:
```
https://stock-screener-onrender.vercel.app
```

---

## 📊 After Deployment

### Your Public URLs

**API Only** (Render):
```
https://stock-screener-api.onrender.com
```

**Full Web App** (Vercel + Render):
```
https://stock-screener-onrender.vercel.app
```

### Access Your Data

```bash
# NSE Stocks
curl https://stock-screener-api.onrender.com/api/stocks/nse

# NYSE Stocks
curl https://stock-screener-api.onrender.com/api/stocks/nyse

# Force Refresh
curl -X POST https://stock-screener-api.onrender.com/api/refresh
```

---

## 📁 Files Already Prepared for Deployment

- ✅ `Procfile` - Tells Render how to start the app
- ✅ `backend/requirements-prod.txt` - Production dependencies
- ✅ `render.yaml` - Render configuration
- ✅ `.gitignore` - What NOT to push to GitHub
- ✅ `frontend/src/services/api.js` - API client for production

---

## 🆘 If Something Goes Wrong

### Check Render Logs
1. Go to Render Dashboard
2. Click your service
3. Click "Logs" tab
4. See what failed

### Common Issues

| Issue | Solution |
|-------|----------|
| Build failed | Check `requirements-prod.txt` is correct |
| API not responding | Verify `Procfile` exists in root directory |
| Frontend can't reach API | Set `REACT_APP_API_URL` environment variable |
| Port errors | Make sure using `$PORT` env variable |

---

## 💰 Pricing

| Service | Free Tier | Notes |
|---------|-----------|-------|
| **Render Backend** | ✅ Yes (512 MB) | Generous free tier |
| **Vercel Frontend** | ✅ Yes | Excellent for React |
| **GitHub** | ✅ Yes | Unlimited public repos |

**Total Cost**: $0 for free tier (or upgrade to $7/month for better performance)

---

## 🔄 Update After Deployment

To update your app after deployment:

```bash
# Make changes locally
# Then push to GitHub:
git add .
git commit -m "Update description"
git push origin main

# Render automatically redeploys!
```

---

## 📈 Performance Tips

1. **First request might be slow** (cold start on free tier)
2. **Cache is working** - Subsequent requests are instant
3. **To improve**: Upgrade Render plan to $7/month for "always on"

---

## 🎓 Estimated Timeline

| Step | Time |
|------|------|
| Create GitHub account | 2 min |
| Push code to GitHub | 3 min |
| Create Render account | 2 min |
| Deploy backend | 5 min |
| Test API | 1 min |
| Deploy frontend (optional) | 5 min |
| **Total** | **~20 min** |

---

## 🚀 Next Steps

### Right Now
1. ✅ Create GitHub account (if needed)
2. ✅ Push code to GitHub
3. ✅ Deploy to Render
4. ✅ Test the API

### After That
1. Share your URL with others
2. Monitor performance on Render dashboard
3. Consider upgrading to paid tier for better uptime

---

## 📞 Support

If you need help:
- Render Docs: https://render.com/docs
- GitHub Docs: https://docs.github.com
- Vercel Docs: https://vercel.com/docs

---

## 📋 Deployment Checklist

```
GitHub Setup:
☐ GitHub account created
☐ Repository created
☐ Code pushed to GitHub

Render Backend:
☐ Render account created
☐ Web Service created
☐ Build command set correctly
☐ Start command set correctly
☐ Deployment successful
☐ API responding at /api/health

Vercel Frontend (Optional):
☐ Vercel account created
☐ Project connected to GitHub
☐ REACT_APP_API_URL set
☐ Deployment successful
☐ Frontend loading in browser

Testing:
☐ Backend API test passed
☐ Frontend connects to backend
☐ NSE stocks loading
☐ NYSE stocks loading
☐ Market toggle working
☐ Cache indicator showing
```

---

## 🎉 Congratulations!

Once you complete these steps, your Stock Screener will be **live on the internet!**

Share your public URL with anyone and they can access it from anywhere in the world.

---

**Need help with any step? Let me know!** 🚀
