import logging
from typing import List, Dict, Any
import random
from datetime import datetime

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Mock data for demonstration
MOCK_NSE_DATA = [
    {"ticker": "TCS.NS", "price": 3250.50, "pe": 18.5, "vol_ratio": 2.45, "rsi": 65.3},
    {"ticker": "INFY.NS", "price": 1850.25, "pe": 16.2, "vol_ratio": 2.35, "rsi": 62.1},
    {"ticker": "WIPRO.NS", "price": 425.80, "pe": 17.8, "vol_ratio": 2.65, "rsi": 68.5},
    {"ticker": "RELIANCE.NS", "price": 2785.60, "pe": 19.2, "vol_ratio": 2.15, "rsi": 55.2},
    {"ticker": "LT.NS", "price": 3125.45, "pe": 15.9, "vol_ratio": 2.85, "rsi": 70.1},
    {"ticker": "HDFCBANK.NS", "price": 1625.30, "pe": 18.1, "vol_ratio": 2.55, "rsi": 63.8},
    {"ticker": "MARUTI.NS", "price": 11850.75, "pe": 14.5, "vol_ratio": 3.05, "rsi": 72.3},
    {"ticker": "ASIANPAINT.NS", "price": 3145.20, "pe": 19.8, "vol_ratio": 2.25, "rsi": 58.9},
    {"ticker": "DMART.NS", "price": 5425.90, "pe": 16.7, "vol_ratio": 2.75, "rsi": 67.2},
    {"ticker": "SUNPHARMA.NS", "price": 745.50, "pe": 15.2, "vol_ratio": 2.45, "rsi": 61.5},
]

MOCK_NYSE_DATA = [
    {"ticker": "AAPL", "price": 195.75, "pe": 19.2, "vol_ratio": 2.35, "rsi": 64.2},
    {"ticker": "MSFT", "price": 420.50, "pe": 18.5, "vol_ratio": 2.55, "rsi": 66.8},
    {"ticker": "NVDA", "price": 875.25, "pe": 17.2, "vol_ratio": 2.85, "rsi": 69.5},
    {"ticker": "GOOGL", "price": 185.40, "pe": 16.8, "vol_ratio": 2.45, "rsi": 62.1},
    {"ticker": "TSLA", "price": 285.75, "pe": 19.8, "vol_ratio": 2.15, "rsi": 56.3},
    {"ticker": "META", "price": 625.30, "pe": 15.5, "vol_ratio": 2.75, "rsi": 68.7},
    {"ticker": "AMZN", "price": 205.85, "pe": 17.9, "vol_ratio": 2.65, "rsi": 65.4},
    {"ticker": "BRK.B", "price": 425.20, "pe": 14.2, "vol_ratio": 2.25, "rsi": 59.8},
    {"ticker": "JNJ", "price": 160.75, "pe": 18.2, "vol_ratio": 2.35, "rsi": 61.2},
    {"ticker": "V", "price": 285.50, "pe": 16.1, "vol_ratio": 2.55, "rsi": 63.9},
]

class DemoScreener:
    def __init__(self):
        logger.info("Using demo/mock screener")

    def screen_nse(self) -> List[Dict[str, Any]]:
        results = []
        for stock in MOCK_NSE_DATA:
            score = stock['rsi'] * stock['vol_ratio']
            results.append({
                'ticker': stock['ticker'],
                'current_price': stock['price'],
                'pe_ratio': stock['pe'],
                'volume_ratio': stock['vol_ratio'],
                'rsi': stock['rsi'],
                'rank_score': round(score, 1)
            })
        results.sort(key=lambda x: x['rank_score'], reverse=True)
        logger.info(f"Screened {len(results)} NSE stocks")
        return results

    def screen_nyse(self) -> List[Dict[str, Any]]:
        results = []
        for stock in MOCK_NYSE_DATA:
            score = stock['rsi'] * stock['vol_ratio']
            results.append({
                'ticker': stock['ticker'],
                'current_price': stock['price'],
                'pe_ratio': stock['pe'],
                'volume_ratio': stock['vol_ratio'],
                'rsi': stock['rsi'],
                'rank_score': round(score, 1)
            })
        results.sort(key=lambda x: x['rank_score'], reverse=True)
        logger.info(f"Screened {len(results)} NYSE stocks")
        return results
