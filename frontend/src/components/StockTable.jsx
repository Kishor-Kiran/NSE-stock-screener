import React from 'react';
import '../styles/StockTable.css';

function StockTable({ stocks, market }) {
  const getTickerLink = (ticker) => {
    if (market === 'NSE') {
      return `https://www.nseindia.com/`;
    } else {
      return `https://www.yahoo.com/quote/${ticker.replace('.NS', '')}`;
    }
  };

  const getRSIColor = (rsi) => {
    if (rsi >= 70) return '#ff6b6b'; // Overbought
    if (rsi >= 50) return '#51cf66'; // Bullish
    return '#ffd93d'; // Neutral
  };

  const getVolumeSpikeBadge = (ratio) => {
    if (ratio > 3) return '🔥 High';
    if (ratio > 2.5) return '📈 Very Good';
    return '✓ Good';
  };

  return (
    <div className="stock-table-container">
      <table className="stock-table">
        <thead>
          <tr>
            <th>Rank</th>
            <th>Ticker</th>
            <th>Current Price</th>
            <th>P/E Ratio</th>
            <th>Volume Ratio</th>
            <th>RSI (14)</th>
            <th>Score</th>
          </tr>
        </thead>
        <tbody>
          {stocks.map((stock, index) => (
            <tr key={stock.ticker} className="stock-row">
              <td className="rank">#{index + 1}</td>
              <td className="ticker">
                <a
                  href={getTickerLink(stock.ticker)}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="ticker-link"
                >
                  {stock.ticker.replace('.NS', '')}
                </a>
              </td>
              <td className="price">
                ₹{stock.current_price}
              </td>
              <td className="pe-ratio">
                <span className={stock.pe_ratio < 15 ? 'very-good' : 'good'}>
                  {stock.pe_ratio}
                </span>
              </td>
              <td className="volume-ratio">
                <span className="volume-badge">
                  {getVolumeSpikeBadge(stock.volume_ratio)}
                </span>
                <span className="volume-value">
                  {stock.volume_ratio.toFixed(2)}x
                </span>
              </td>
              <td className="rsi">
                <div
                  className="rsi-bar"
                  style={{
                    backgroundColor: getRSIColor(stock.rsi),
                    width: `${(stock.rsi / 100) * 100}%`,
                  }}
                >
                  <span className="rsi-value">{stock.rsi}</span>
                </div>
              </td>
              <td className="score">
                <span className="score-value">
                  {(stock.rank_score || 0).toFixed(1)}
                </span>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default StockTable;
