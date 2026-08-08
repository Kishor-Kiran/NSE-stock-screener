# Stock Screener - Public Deployment Guide (Render)

## 📋 Prerequisites

1. **GitHub Account** (free) - https://github.com/signup
2. **Render Account** (free) - https://render.com/
3. **Git installed** on your computer
4. **All files ready** ✅ (Already prepared)

---

## 🚀 Step-by-Step Deployment

### Step 1: Initialize Git Repository

```bash
cd D:\Kiran\Thrissur\TCEDERP

# Initialize git
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Stock Screener Full-Stack Application"
```

### Step 2: Create GitHub Repository

1. Go to https://github.com/new
2. **Repository name**: `stock-screener`
3. **Description**: "Real-time stock screener for NSE and NYSE"
4. **Public** (so Render can access)
5. Click "Create repository"

### Step 3: Connect Local Repository to GitHub

After creating repo on GitHub, you'll see instructions. Follow this:

```bash
cd D:\Kiran\Thrissur\TCEDERP

# Add remote
git remote add origin https://github.com/YOUR_USERNAME/stock-screener.git

# Rename branch to main
git branch -M main

# Push to GitHub
git push -u origin main
```

**Replace `YOUR_USERNAME` with your actual GitHub username**

### Step 4: Deploy on Render

1. **Create Render Account**: https://render.com/
2. Go to Dashboard
3. Click **"New +"** → **"Web Service"**
4. Select **"Connect a repository"**
5. Search for `stock-screener`
6. Click **"Connect"**

### Step 5: Configure Render Service

Fill in the following:

| Field | Value |
|-------|-------|
| **Name** | `stock-screener-api` |
| **Environment** | `Python 3` |
| **Build Command** | `pip install -r backend/requirements-prod.txt` |
| **Start Command** | `cd backend && gunicorn app_demo:app --bind 0.0.0.0:$PORT` |
| **Plan** | `Free` |

### Step 6: Set Environment Variables (Optional)

Click **"Advanced"** and add:
```
FLASK_ENV = production
PYTHONUNBUFFERED = true
```

### Step 7: Deploy

Click **"Create Web Service"**

Wait 3-5 minutes for deployment. You'll see:
```
✓ Build successful
✓ Deployment successful
```

---

## 📱 Your Public URLs

After deployment completes, you'll get:

### Backend API URL
```
https://stock-screener-api.onrender.com
```

### Test the API

```bash
# Health check
curl https://stock-screener-api.onrender.com/api/health

# Get NSE stocks
curl https://stock-screener-api.onrender.com/api/stocks/nse

# Get NYSE stocks
curl https://stock-screener-api.onrender.com/api/stocks/nyse
```

---

## 🎨 Frontend Deployment (Optional - Static Site)

For the React frontend, you have options:

### Option A: Deploy Frontend to Vercel (Recommended, Free)

1. Go to https://vercel.com
2. Click "Import Project"
3. Select your GitHub repo
4. **Framework**: React
5. **Build Command**: `cd frontend && npm run build`
6. **Output Directory**: `frontend/build`
7. Add Environment Variable:
   ```
   REACT_APP_API_URL = https://stock-screener-api.onrender.com
   ```
8. Click "Deploy"

You'll get a URL like: `https://stock-screener.vercel.app`

### Option B: Deploy Frontend on Render (as Static Site)

1. On Render Dashboard: **New** → **Static Site**
2. Connect same GitHub repo
3. **Build Command**: `cd frontend && npm run build`
4. **Publish Directory**: `frontend/build`
5. **Environment Variable**:
   ```
   REACT_APP_API_URL = https://stock-screener-api.onrender.com
   ```
6. Deploy

---

## 🔌 Connecting Frontend to Backend

Update the frontend to use your deployed backend:

### Edit: `frontend/package.json`

```json
{
  ...
  "proxy": "https://stock-screener-api.onrender.com",
  ...
}
```

Or create `.env.production` in frontend:

```
REACT_APP_API_URL=https://stock-screener-api.onrender.com
```

Then in `frontend/src/services/api.js`:

```javascript
const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:5000';

export const getStocks = (market) => {
  return axios.get(`${API_URL}/api/stocks/${market.toLowerCase()}`);
};
```

---

## ✅ Verification Checklist

- [ ] GitHub repository created
- [ ] Code pushed to GitHub
- [ ] Render account created
- [ ] Backend service deployed
- [ ] Backend API responding (test `/api/health`)
- [ ] Frontend deployed (if using Vercel/Render)
- [ ] Frontend connects to backend API
- [ ] Both NSE and NYSE data loading
- [ ] Cache working correctly

---

## 🔗 Final URLs

Once deployed, you'll have:

**Backend API**: 
```
https://stock-screener-api.onrender.com
```

**Frontend UI** (if deployed):
```
https://stock-screener.vercel.app
(or https://stock-screener.onrender.com if using Render)
```

**Direct API Access**:
```
https://stock-screener-api.onrender.com/api/stocks/nse
https://stock-screener-api.onrender.com/api/stocks/nyse
```

---

## 🐛 Troubleshooting

### Deployment Failed
- Check build logs on Render
- Ensure all files are committed to Git
- Verify `Procfile` exists and is correct

### API Not Responding
- Check Render service logs
- Verify GitHub push was successful
- Try direct curl to test endpoint

### Frontend Can't Reach Backend
- Update `REACT_APP_API_URL` environment variable
- Check CORS is enabled in Flask
- Verify backend URL is correct

### Database/Data Issues
- Backend uses demo data by default
- To use real yfinance, switch `app_demo.py` to `app.py` in Procfile
- Update Procfile:
  ```
  web: cd backend && gunicorn app:app
  ```

---

## 📈 Performance Notes

**Free Tier Limitations**:
- Services spin down after 15 min of inactivity
- First request takes ~10-30 seconds (cold start)
- Rate limits: yfinance ~2000 calls/hour
- Memory: Limited to 512MB

**To Upgrade**:
- Render Starter Plan: $7/month
- Vercel Pro: $20/month (for frontend)

---

## 🎓 Post-Deployment

### Monitor Your Deployment
- Render Dashboard: https://dashboard.render.com
- View logs in real-time
- Set up alerts for failures

### Scaling Up
If you want better performance:
1. Upgrade to Render Starter Plan ($7/month)
2. Add Redis cache layer
3. Use CDN for frontend (Vercel)

### Switching to Real Data
Update your Procfile to use production screener:
```
web: cd backend && gunicorn app:app
```

---

## 📞 Quick Reference

### API Endpoints
```
GET  https://stock-screener-api.onrender.com/api/health
GET  https://stock-screener-api.onrender.com/api/stocks/nse
GET  https://stock-screener-api.onrender.com/api/stocks/nyse
POST https://stock-screener-api.onrender.com/api/refresh
```

### Useful Links
- Render Docs: https://render.com/docs
- Vercel Docs: https://vercel.com/docs
- GitHub Help: https://docs.github.com

---

## 🎉 You're Ready!

Once you follow these steps, your Stock Screener will be live on the internet! 🚀

**Estimated Time**: 15-20 minutes
**Cost**: FREE (using free tiers)
**Scalability**: Can easily upgrade if needed

Share your URL: `https://stock-screener-api.onrender.com`
