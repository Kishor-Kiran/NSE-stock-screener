# Stock Screener - Real-time Technical Analysis Tool

A full-stack application that screens NSE (Nifty 500) and NYSE stocks in real-time based on technical and fundamental indicators.

## 📊 Features

✅ **Dual Market Support**: Indian NSE (Nifty 500) and US NYSE stocks  
✅ **Real-time Filtering**: Updates every 30 seconds automatically  
✅ **Smart Caching**: 30-second cache to optimize API calls  
✅ **Technical Indicators**: RSI (14), Volume Spike Detection  
✅ **Fundamental Screening**: P/E Ratio < 20  
✅ **Interactive UI**: React-based responsive dashboard  
✅ **Live Rankings**: Stocks ranked by composite score  

## 🎯 Screening Criteria

- **P/E Ratio**: < 20 (Value stocks)
- **Volume Spike**: > 2x of 20-day average (High liquidity)
- **RSI (14)**: > 50 (Momentum indicator)
- **Historical Data**: 1 year of data for analysis

## 🛠️ Technology Stack

| Component | Technology |
|-----------|-----------|
| Backend | Python Flask |
| Frontend | React.js 18 |
| Data Source | yfinance |
| Technical Analysis | TA-Lib (ta) |
| HTTP Client | Axios |
| API Framework | Flask-CORS |

## 📋 Prerequisites

- **Python 3.8+** (for backend)
- **Node.js 14+** (for frontend)
- **npm or yarn** (for React dependencies)
- **Internet connection** (for yfinance API)

## 🚀 Installation & Setup

### Step 1: Clone/Navigate to Project

```bash
cd D:\Kiran\Thrissur\TCEDERP
```

### Step 2: Backend Setup

```bash
# Navigate to backend directory
cd backend

# Create virtual environment (recommended)
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

### Step 3: Frontend Setup

```bash
# Navigate to frontend directory (from project root)
cd frontend

# Install dependencies
npm install

# Create .env file (optional, for API configuration)
echo "REACT_APP_API_URL=http://localhost:5000" > .env
```

## 🏃 Running the Application

### Terminal 1: Start Flask Backend (Port 5000)

```bash
cd backend

# Activate virtual environment first
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate

# Start Flask server
python app.py
```

**Expected Output:**
```
 * Running on http://127.0.0.1:5000
 * Press CTRL+C to quit
```

### Terminal 2: Start React Frontend (Port 3000)

```bash
cd frontend

# Start development server
npm start
```

**Expected Output:**
```
webpack compiled successfully
Compiled successfully!

You can now view stock-screener in the browser.

  Local:            http://localhost:3000
```

### Step 3: Open in Browser

Once both servers are running, open your browser and navigate to:

```
http://localhost:3000
```

## 📱 Usage Guide

### 1. **Select Market**
   - Click "🇮🇳 NSE (Nifty 500)" for Indian stocks
   - Click "🇺🇸 NYSE" for US stocks

### 2. **View Stocks**
   - All filtered stocks appear automatically
   - Sorted by composite ranking score
   - Auto-refreshes every 30 seconds

### 3. **Interpret Data**
   - **Rank**: Position in filtered list
   - **P/E**: Lower is better (< 15 is excellent)
   - **Volume Ratio**: >2.5x is very good, >3x is excellent
   - **RSI**: >70 overbought, 50-70 bullish, <50 bearish
   - **Score**: Composite ranking (RSI × Volume Ratio)

### 4. **Manual Refresh**
   - Click "⟳ Refresh" button to force immediate refresh
   - Bypasses cache for fresh data

## 🔌 API Endpoints

### Base URL
```
http://localhost:5000
```

### Endpoints

#### 1. Health Check
```bash
GET /api/health
```
**Response:**
```json
{"status": "healthy"}
```

#### 2. Get NSE Stocks
```bash
GET /api/stocks/nse
```
**Response:**
```json
{
  "market": "NSE",
  "stocks": [
    {
      "ticker": "TCS.NS",
      "current_price": 3250.50,
      "pe_ratio": 18.5,
      "volume_ratio": 2.45,
      "rsi": 65.3,
      "rank_score": 159.8
    }
  ],
  "count": 42,
  "cached": false
}
```

#### 3. Get NYSE Stocks
```bash
GET /api/stocks/nyse
```
**Response:** Same structure as NSE endpoint

#### 4. Force Refresh (Clear Cache)
```bash
POST /api/refresh
```
**Response:**
```json
{"status": "cache cleared"}
```

## 📊 Data Refresh Behavior

| Scenario | Behavior |
|----------|----------|
| First load | Fetches fresh data (~10-30 sec) |
| Within 30 sec | Returns cached results |
| After 30 sec | Fetches fresh data (if auto-refresh) |
| Manual refresh | Always fetches fresh data |

## ⚙️ Configuration

### Backend Configuration
Edit `backend/screener.py`:

```python
# Change screening criteria
StockScreener().screen_stocks(
    max_pe=20,              # P/E threshold
    min_volume_spike=2.0,   # Volume multiplier
    min_rsi=50              # RSI threshold
)

# Change stock lists
NIFTY_500_TICKERS = [...]  # Edit NSE stocks
NYSE_TICKERS = [...]        # Edit NYSE stocks
```

### Cache Duration
Edit `backend/app.py`:

```python
cache_manager = CacheManager(ttl_seconds=30)  # Change from 30 to desired seconds
```

## 🐛 Troubleshooting

### Issue: "Cannot GET /api/stocks/nse"
**Solution:** Ensure Flask backend is running on port 5000
```bash
# Check if port 5000 is in use
netstat -ano | findstr :5000  # Windows
lsof -i :5000                  # macOS/Linux
```

### Issue: "No matching stocks found"
**Possible causes:**
- Market conditions don't meet strict criteria
- yfinance API rate limit reached
- Check internet connectivity

### Issue: CORS Error in Browser Console
**Solution:** Flask-CORS should handle this, but if not:
```python
# In backend/app.py, ensure CORS is initialized
CORS(app)
```

### Issue: "ModuleNotFoundError" for yfinance
**Solution:** Reinstall requirements
```bash
cd backend
pip install -r requirements.txt --upgrade
```

### Issue: React app won't load
**Solution:** Check Node.js installation
```bash
node --version
npm --version
# Should show versions
```

## 📈 Performance Notes

- **API Calls**: Limited by yfinance (usually 2000/hour)
- **Processing Time**: ~10-30 seconds per market scan
- **Caching**: Reduces API calls by ~90%
- **Memory**: ~100-200 MB for both services

## 🔄 Auto-Refresh Interval

Frontend automatically refreshes every 30 seconds. To change:

Edit `frontend/src/App.jsx`:
```javascript
}, 30000); // Change 30000 (milliseconds) to desired interval
```

## 📚 Stock List Expansion

To add more stocks:

1. **For NSE**: Edit `backend/screener.py` → `NIFTY_500_TICKERS` list
2. **For NYSE**: Edit `backend/screener.py` → `NYSE_TICKERS` list

Add tickers in format:
- NSE: `"COMPANY.NS"` (e.g., "RELIANCE.NS")
- NYSE: `"TICKER"` (e.g., "AAPL")

## 🎨 UI Customization

### Colors
Edit `frontend/src/App.css` and `frontend/src/styles/*.css`:
```css
/* Change primary color */
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
```

### Table Styling
Edit `frontend/src/styles/StockTable.css` for table appearance

## 🔐 Security Notes

⚠️ **Current Implementation**:
- No authentication required
- No data persistence (all RAM-based)
- No production-grade error handling

**For Production**:
- Add authentication layer
- Implement database for historical data
- Add rate limiting
- Use environment variables for config
- Add proper logging/monitoring

## 📞 Support

For issues or questions:
- Check logs in both terminal windows
- Verify all ports (3000, 5000) are available
- Ensure stable internet for yfinance API

## 📄 License

This project is for educational purposes. yfinance data is subject to Yahoo Finance terms.

---

**Happy Trading! 📊**
