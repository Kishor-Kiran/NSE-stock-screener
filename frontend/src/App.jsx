import React, { useState, useEffect } from 'react';
import axios from 'axios';
import StockTable from './components/StockTable';
import MarketToggle from './components/MarketToggle';
import './App.css';

function App() {
  const [market, setMarket] = useState('NSE');
  const [stocks, setStocks] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [lastUpdate, setLastUpdate] = useState(null);
  const [cached, setCached] = useState(false);

  const fetchStocks = async (selectedMarket) => {
    setLoading(true);
    setError(null);

    try {
      const endpoint = selectedMarket === 'NSE' ? '/api/stocks/nse' : '/api/stocks/nyse';
      const response = await axios.get(endpoint);

      setStocks(response.data.stocks || []);
      setCached(response.data.cached);
      setLastUpdate(new Date().toLocaleTimeString());

      if (response.data.count === 0) {
        setError(`No stocks matching criteria in ${selectedMarket}`);
      }
    } catch (err) {
      setError(`Failed to fetch stocks: ${err.message}`);
      console.error('Error fetching stocks:', err);
    } finally {
      setLoading(false);
    }
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
            <span className="label cache-badge">
              {cached ? '✓ Cached' : 'Fresh'}
            </span>
          </div>
        </div>

        {error && (
          <div className="error-message">
            {error}
          </div>
        )}

        {!error && stocks.length === 0 && !loading && (
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
        <p>Data provided by Yahoo Finance | Auto-refresh every 30 seconds</p>
      </footer>
    </div>
  );
}

export default App;
