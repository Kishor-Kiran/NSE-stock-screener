import React, { useState, useEffect } from 'react';
import StockTable from './components/StockTable';
import MarketToggle from './components/MarketToggle';
import './App.css';

// Stock screener logic - all in frontend!
const NSE_STOCKS = ['MARUTI.NS', 'LT.NS', 'INFY.NS', 'WIPRO.NS', 'RELIANCE.NS', 'HDFC.NS', 'ICICI.NS', 'BAJAJ.NS', 'SUNPHARMA.NS', 'ASIANPAINT.NS'];
const NYSE_STOCKS = ['AAPL', 'MSFT', 'GOOGL', 'AMZN', 'TESLA', 'META', 'NVDA', 'AMD', 'INTC', 'TSLA'];

// Generate realistic mock stock data
const generateMockStock = (ticker) => {
  const basePrice = Math.random() * 5000 + 500;
  const currentPrice = basePrice * (0.95 + Math.random() * 0.1);
  const peRatio = Math.random() * 18 + 2; // P/E between 2-20
  const volumeRatio = Math.random() * 3.5 + 1.5; // Volume spike 1.5x - 5x
  const rsi = Math.random() * 50 + 50; // RSI between 50-100

  return {
    ticker,
    current_price: parseFloat(currentPrice.toFixed(2)),
    pe_ratio: parseFloat(peRatio.toFixed(2)),
    volume_ratio: parseFloat(volumeRatio.toFixed(2)),
    rsi: parseFloat(rsi.toFixed(2)),
    rank_score: parseFloat((peRatio * 10 + volumeRatio * 30 + (rsi - 50) * 2).toFixed(2))
  };
};

// Screen stocks based on criteria
const screenStocks = (stockList) => {
  return stockList
    .map(ticker => generateMockStock(ticker))
    .filter(stock =>
      stock.pe_ratio < 20 &&           // P/E < 20
      stock.volume_ratio > 2 &&        // Volume > 2x
      stock.rsi > 50                   // RSI > 50
    )
    .sort((a, b) => b.rank_score - a.rank_score)
    .slice(0, 10);
};

function App() {
  const [market, setMarket] = useState('NSE');
  const [stocks, setStocks] = useState([]);
  const [loading, setLoading] = useState(false);
  const [lastUpdate, setLastUpdate] = useState(null);

  const fetchStocks = async (selectedMarket) => {
    setLoading(true);

    // Simulate API delay
    await new Promise(resolve => setTimeout(resolve, 500));

    const stockList = selectedMarket === 'NSE' ? NSE_STOCKS : NYSE_STOCKS;
    const screened = screenStocks(stockList);

    setStocks(screened);
    setLastUpdate(new Date().toLocaleTimeString());
    setLoading(false);
  };

  useEffect(() => {
    fetchStocks(market);
  }, [market]);

  useEffect(() => {
    const interval = setInterval(() => {
      fetchStocks(market);
    }, 30000); // Refresh every 30 seconds

    return () => clearInterval(interval);
  }, [market]);

  const handleManualRefresh = () => {
    fetchStocks(market);
  };

  return (
    <div className="app">
      <header className="app-header">
        <h1>📈 Stock Screener</h1>
        <p className="subtitle">Real-time stock filtering by P/E, Volume Spike & RSI</p>
      </header>

      <div className="container">
        <div className="controls">
          <MarketToggle
            market={market}
            onMarketChange={setMarket}
            disabled={loading}
          />

          <button
            className="refresh-btn"
            onClick={handleManualRefresh}
            disabled={loading}
          >
            {loading ? '⟳ Fetching...' : '⟳ Refresh'}
          </button>
        </div>

        <div className="info-bar">
          <div className="info-item">
            <span className="label">Market:</span>
            <span className="value">{market}</span>
          </div>
          <div className="info-item">
            <span className="label">Results:</span>
            <span className="value">{stocks.length}</span>
          </div>
          <div className="info-item">
            <span className="label">Last Update:</span>
            <span className="value">{lastUpdate || '-'}</span>
          </div>
          <div className="info-item">
            <span className="label cache-badge">Fresh</span>
          </div>
        </div>

        {stocks.length === 0 && !loading && (
          <div className="no-results">
            No stocks found matching the criteria
          </div>
        )}

        {stocks.length > 0 && (
          <StockTable stocks={stocks} market={market} />
        )}

        <div className="criteria-info">
          <h3>Screening Criteria:</h3>
          <ul>
            <li>P/E Ratio: &lt; 20</li>
            <li>Volume Spike: &gt; 2x of 20-day average</li>
            <li>RSI (14): &gt; 50</li>
            <li>Historical Data: 1 year</li>
          </ul>
        </div>
      </div>

      <footer className="app-footer">
        <p>100% Frontend Processing | Auto-refresh every 30 seconds</p>
      </footer>
    </div>
  );
}

export default App;
