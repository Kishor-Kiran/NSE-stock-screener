# Stock Screener - TCEDERP Project

## Project Overview
A real-time stock screener application that fetches and filters stocks from Indian NSE (Nifty 500) and US NYSE markets based on technical and fundamental indicators.

### Key Features
- Real-time stock data fetching using yfinance library
- Technical analysis: RSI (Relative Strength Index), Volume spike detection
- Fundamental analysis: P/E ratio filtering
- Dual market support: NSE (Nifty 500) and NYSE
- 30-second auto-refresh interval
- 30-second data caching to reduce API load
- Full-stack application: Flask backend + React frontend

## Technology Stack
- **Backend**: Python Flask
- **Frontend**: React.js
- **Data Source**: yfinance library
- **Port**: 3000 (React dev server) / 5000 (Flask API)
- **OS**: Windows 10 Pro

## Project Structure
```
stock-screener/
├── backend/                    # Flask API server
│   ├── app.py                 # Flask application entry point
│   ├── requirements.txt        # Python dependencies
│   ├── screener.py            # Core screening logic
│   ├── cache.py               # Caching with 30-second expiry
│   └── config.py              # Configuration settings
├── frontend/                   # React application
│   ├── src/
│   │   ├── App.jsx            # Main component
│   │   ├── components/        # React components
│   │   │   ├── StockTable.jsx
│   │   │   ├── MarketToggle.jsx
│   │   │   └── FilterPanel.jsx
│   │   └── services/          # API calls
│   │       └── api.js
│   └── package.json
└── README.md
```

## Configuration Details
- **Historical Data**: 1 year (365 days)
- **Indicators**:
  - P/E Ratio: < 20
  - Volume Spike: > 2x of 20-day average
  - RSI: > 50
- **Results**: Display all matching stocks
- **Market Toggle**: NSE ↔ NYSE
- **Cache Expiry**: 30 seconds

## API Endpoints
- `GET /api/stocks/nse` - Fetch NSE (Nifty 500) filtered stocks
- `GET /api/stocks/nyse` - Fetch NYSE filtered stocks
- `POST /api/refresh` - Force refresh (bypasses cache)

## Development Workflow
1. Install dependencies for both backend and frontend
2. Start Flask backend on http://localhost:5000
3. Start React development server on http://localhost:3000
4. Frontend will proxy API calls to Flask backend

## Key Implementation Details
- **Cache Layer**: 30-second TTL cache for stock data
- **Batch Processing**: Efficient filtering of 500+ stocks
- **Error Handling**: Graceful fallbacks for API failures
- **Rate Limiting**: Respects yfinance rate limits
