# Quick Start Guide - Stock Screener

## ⚡ 5-Minute Setup

### Prerequisites Check
```bash
python --version          # Should be 3.8+
node --version            # Should be 14+
npm --version             # Should be 6+
```

---

## 🚀 Step-by-Step

### 1️⃣ Backend Setup (3 minutes)

```bash
# Navigate to backend
cd backend

# Create virtual environment
python -m venv venv

# Activate (Windows)
venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

**✓ Done! Move to Terminal 2**

---

### 2️⃣ Frontend Setup (2 minutes)

**In a new terminal:**

```bash
# Navigate to frontend
cd frontend

# Install dependencies
npm install
```

**✓ Done! Ready to run**

---

## ▶️ Running (Keep 2 terminals open)

### Terminal 1: Backend Server
```bash
cd backend
venv\Scripts\activate        # Windows
python app.py
```

**Wait for:** `Running on http://127.0.0.1:5000`

---

### Terminal 2: Frontend Server
```bash
cd frontend
npm start
```

**Wait for:** `Compiled successfully!`

---

## 🌐 Access Application

**Browser:** `http://localhost:3000`

---

## 📊 First Run Expected Results

1. **Page loads** with purple gradient background
2. **NSE market selected** by default
3. **"Fetching..." message** appears (10-30 seconds)
4. **Stock table displays** with results ranked

### Sample Output (NSE)
```
Rank | Ticker | Price   | P/E  | Vol Ratio | RSI  | Score
-----|--------|---------|------|-----------|------|-------
1    | TCS    | ₹3250   | 18.5 | 2.45x     | 65.3 | 159.8
2    | INFY   | ₹1850   | 16.2 | 2.35x     | 62.1 | 145.8
...
```

---

## 🎯 Test Features

1. **Toggle Market**
   - Click "🇮🇳 NSE" or "🇺🇸 NYSE"
   - Watch data refresh

2. **Manual Refresh**
   - Click "⟳ Refresh" button
   - Watch cache indicator change

3. **Auto Refresh**
   - Wait 30 seconds
   - Data updates automatically

4. **View Stock Details**
   - Click ticker name
   - Opens Yahoo Finance page

---

## ⚠️ Common Issues

### Issue: Port 5000 already in use
```bash
# Find and kill process (Windows)
netstat -ano | findstr :5000
taskkill /PID <PID> /F

# Or change port in backend/app.py
app.run(debug=True, port=5001)  # Change 5000 to 5001
```

### Issue: "npm: command not found"
- Node.js not installed
- Download: https://nodejs.org/

### Issue: "No stocks found"
- Market conditions might not meet criteria
- Check browser console for errors
- Try NYSE market instead

---

## 📝 Configuration

### Change Refresh Interval
**File:** `frontend/src/App.jsx` (line ~46)
```javascript
}, 30000);  // milliseconds (30000 = 30 seconds)
```

### Change Screening Criteria
**File:** `backend/screener.py` (line ~68)
```python
def screen_stocks(self, tickers,
                 max_pe=20,              # ← Change P/E
                 min_volume_spike=2.0,   # ← Change volume
                 min_rsi=50)             # ← Change RSI
```

### Add More Stocks
**File:** `backend/screener.py`

NSE stocks (line ~11-18):
```python
NIFTY_500_TICKERS = [
    "TCS.NS", "RELIANCE.NS", ... # Add more tickers
]
```

NYSE stocks (line ~30-37):
```python
NYSE_TICKERS = [
    "AAPL", "MSFT", ... # Add more tickers
]
```

---

## 🎨 UI Customization

### Change Colors
**File:** `frontend/src/App.css` (line ~15)
```css
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
/* Change hex codes: #667eea, #764ba2 */
```

### Change Refresh Speed
**File:** `frontend/src/App.jsx` (line ~46)
```javascript
}, 30000);  // Change 30000 to your milliseconds
```

---

## 🔍 Monitoring

### Backend Logs
Watch Terminal 1 for:
```
INFO:screener:Screening 500 NSE stocks...
INFO:screener:Match found: TCS.NS - PE: 18.5, Vol Ratio: 2.45, RSI: 65.3
```

### Frontend Logs
Open browser DevTools (F12) → Console for:
```javascript
GET http://localhost:5000/api/stocks/nse 200
```

---

## 📊 Data Interpretation

| Metric | Good | Very Good | Excellent |
|--------|------|-----------|-----------|
| P/E | < 20 | < 15 | < 10 |
| Volume Ratio | > 2x | > 2.5x | > 3x |
| RSI | 50-70 | 60-70 | 65-75 |

---

## 🎓 Learn More

- **CLAUDE.md** - Project documentation
- **README.md** - Full features & API docs
- **YouTube Reference** - Original tutorial approach

---

## ✅ Success Checklist

- [ ] Backend running on port 5000
- [ ] Frontend running on port 3000
- [ ] Browser shows stock screener UI
- [ ] Market toggle works
- [ ] Data displays in table
- [ ] Auto-refresh every 30 seconds
- [ ] Manual refresh button works

**All checked? You're ready! 🚀**

---

**Need help?** Check terminal outputs for error messages.
