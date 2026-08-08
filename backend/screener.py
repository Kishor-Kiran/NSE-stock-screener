import yfinance as yf
import pandas as pd
import numpy as np
import logging
from typing import List, Dict, Any

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

NIFTY_500_TICKERS = [
    "RELIANCE.NS", "TCS.NS", "HDFCBANK.NS", "INFY.NS", "HDFC.NS",
    "LT.NS", "MARUTI.NS", "BAJAJFINSV.NS", "AXIS.NS", "ASIANPAINT.NS",
    "DMART.NS", "SUNPHARMA.NS", "WIPRO.NS", "LUPIN.NS", "M&M.NS",
    "NESTLEIND.NS", "ICICIBANK.NS", "SBILIFE.NS", "POWERGRID.NS", "TITAN.NS",
    "BHARTI.NS", "JSWSTEEL.NS", "HEROMOTOCO.NS", "UPL.NS", "GAIL.NS",
    "NTPC.NS", "CIPLA.NS", "COALINDIA.NS", "ADANIGREEN.NS", "ADANIPOWER.NS",
    "EICHERMOT.NS", "BAJAJ-AUTO.NS", "BEL.NS", "PAGEIND.NS", "HAVELLS.NS",
    "INDIGO.NS", "IOC.NS", "KOTAKBANK.NS", "ITC.NS", "VOLTAS.NS",
    "TECHM.NS", "HCL-INSYS.NS", "BIOCON.NS", "PEL.NS", "APOLLOTYRE.NS",
    # Adding more for Nifty 500 sample (full list would be much longer)
    "BATAINDIA.NS", "PIDILITIND.NS", "SBIN.NS", "AUROPHARMA.NS", "HINDUNILVR.NS",
    "MCDOWELL-N.NS", "MANAPPURAM.NS", "MINDTREE.NS", "NH.NS", "OBEROIRLTY.NS",
    "PFC.NS", "PNB.NS", "POLYCAB.NS", "RBLBANK.NS", "RECLTD.NS"
]

NYSE_TICKERS = [
    "AAPL", "MSFT", "GOOGL", "AMZN", "NVDA",
    "META", "TSLA", "BRK.B", "JNJ", "V",
    "WMT", "JPM", "PG", "MA", "INTC",
    "CSCO", "CMCSA", "PEP", "COST", "MCD",
    "ABD", "ADBE", "AMD", "AXP", "BA",
    "C", "CAT", "CRWD", "CRM", "DDOG",
    "ETN", "FANG", "GLD", "GS", "HD",
    "HUM", "IBM", "INTU", "JCI", "KO"
]

class StockScreener:
    def __init__(self, period: str = "1y"):
        self.period = period
        self.interval = "1d"

    def fetch_stock_data(self, ticker: str) -> pd.DataFrame:
        try:
            data = yf.download(ticker, period=self.period, interval=self.interval, progress=False)
            if data.empty:
                return None
            return data
        except Exception as e:
            logger.warning(f"Error fetching data for {ticker}: {str(e)}")
            return None

    def calculate_rsi(self, data: pd.DataFrame, period: int = 14) -> float:
        if len(data) < period + 1:
            return None

        close = data['Close']
        delta = close.diff()
        gain = (delta.where(delta > 0, 0)).rolling(window=period).mean()
        loss = (-delta.where(delta < 0, 0)).rolling(window=period).mean()

        rs = gain / loss
        rsi = 100 - (100 / (1 + rs))
        return rsi.iloc[-1]

    def calculate_volume_ratio(self, data: pd.DataFrame, period: int = 20) -> float:
        if len(data) < period:
            return None
        current_volume = data['Volume'].iloc[-1]
        avg_volume = data['Volume'].iloc[-period:].mean()
        if avg_volume == 0:
            return None
        return current_volume / avg_volume

    def get_pe_ratio(self, ticker: str) -> float:
        try:
            stock = yf.Ticker(ticker)
            info = stock.info
            pe = info.get('trailingPE') or info.get('forwardPE')
            return pe
        except Exception as e:
            logger.warning(f"Error fetching PE for {ticker}: {str(e)}")
            return None

    def get_current_price(self, data: pd.DataFrame) -> float:
        return data['Close'].iloc[-1]

    def screen_stocks(self, tickers: List[str],
                     max_pe: float = 20,
                     min_volume_spike: float = 2.0,
                     min_rsi: float = 50) -> List[Dict[str, Any]]:
        results = []

        for ticker in tickers:
            try:
                data = self.fetch_stock_data(ticker)
                if data is None or data.empty:
                    continue

                current_price = self.get_current_price(data)
                pe_ratio = self.get_pe_ratio(ticker)
                volume_ratio = self.calculate_volume_ratio(data)
                rsi = self.calculate_rsi(data)

                if pe_ratio is None or volume_ratio is None or rsi is None:
                    continue

                if pe_ratio < max_pe and volume_ratio > min_volume_spike and rsi > min_rsi:
                    results.append({
                        'ticker': ticker,
                        'current_price': round(current_price, 2),
                        'pe_ratio': round(pe_ratio, 2),
                        'volume_ratio': round(volume_ratio, 2),
                        'rsi': round(rsi, 2),
                        'rank_score': rsi * volume_ratio  # Ranking metric
                    })
                    logger.info(f"Match found: {ticker} - PE: {pe_ratio}, Vol Ratio: {volume_ratio}, RSI: {rsi}")

            except Exception as e:
                logger.error(f"Error processing {ticker}: {str(e)}")
                continue

        results.sort(key=lambda x: x['rank_score'], reverse=True)
        return results

    def screen_nse(self) -> List[Dict[str, Any]]:
        logger.info(f"Screening {len(NIFTY_500_TICKERS)} NSE stocks...")
        return self.screen_stocks(NIFTY_500_TICKERS)

    def screen_nyse(self) -> List[Dict[str, Any]]:
        logger.info(f"Screening {len(NYSE_TICKERS)} NYSE stocks...")
        return self.screen_stocks(NYSE_TICKERS)
