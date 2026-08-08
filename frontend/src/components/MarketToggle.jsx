import React from 'react';
import '../styles/MarketToggle.css';

function MarketToggle({ market, onMarketChange, disabled }) {
  return (
    <div className="market-toggle-container">
      <label className="toggle-label">Select Market:</label>
      <div className="toggle-group">
        <button
          className={`toggle-btn ${market === 'NSE' ? 'active' : ''}`}
          onClick={() => onMarketChange('NSE')}
          disabled={disabled}
        >
          🇮🇳 NSE (Nifty 500)
        </button>
        <button
          className={`toggle-btn ${market === 'NYSE' ? 'active' : ''}`}
          onClick={() => onMarketChange('NYSE')}
          disabled={disabled}
        >
          🇺🇸 NYSE
        </button>
      </div>
    </div>
  );
}

export default MarketToggle;
