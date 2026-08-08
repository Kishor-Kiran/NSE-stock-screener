import os
from dotenv import load_dotenv

load_dotenv()

# Flask Configuration
DEBUG = os.getenv('DEBUG', 'True').lower() == 'true'
PORT = int(os.getenv('FLASK_PORT', 5000))
HOST = os.getenv('FLASK_HOST', '0.0.0.0')

# Screening Configuration
SCREENING_CONFIG = {
    'period': os.getenv('DATA_PERIOD', '1y'),
    'interval': os.getenv('DATA_INTERVAL', '1d'),
    'max_pe_ratio': float(os.getenv('MAX_PE_RATIO', 20)),
    'min_volume_spike': float(os.getenv('MIN_VOLUME_SPIKE', 2.0)),
    'min_rsi': float(os.getenv('MIN_RSI', 50)),
    'rsi_period': int(os.getenv('RSI_PERIOD', 14)),
    'volume_period': int(os.getenv('VOLUME_PERIOD', 20)),
}

# Cache Configuration
CACHE_CONFIG = {
    'ttl_seconds': int(os.getenv('CACHE_TTL', 30)),
    'enabled': os.getenv('CACHE_ENABLED', 'True').lower() == 'true',
}

# Market Configuration
NSE_ENABLED = os.getenv('NSE_ENABLED', 'True').lower() == 'true'
NYSE_ENABLED = os.getenv('NYSE_ENABLED', 'True').lower() == 'true'

# Nifty 500 Stocks (Sample - expand as needed)
NIFTY_500_STOCKS = [
    "RELIANCE.NS", "TCS.NS", "HDFCBANK.NS", "INFY.NS", "HDFC.NS",
    "LT.NS", "MARUTI.NS", "BAJAJFINSV.NS", "AXIS.NS", "ASIANPAINT.NS",
    "DMART.NS", "SUNPHARMA.NS", "WIPRO.NS", "LUPIN.NS", "M&M.NS",
    "NESTLEIND.NS", "ICICIBANK.NS", "SBILIFE.NS", "POWERGRID.NS", "TITAN.NS",
    "BHARTI.NS", "JSWSTEEL.NS", "HEROMOTOCO.NS", "UPL.NS", "GAIL.NS",
    "NTPC.NS", "CIPLA.NS", "COALINDIA.NS", "ADANIGREEN.NS", "ADANIPOWER.NS",
    "EICHERMOT.NS", "BAJAJ-AUTO.NS", "BEL.NS", "PAGEIND.NS", "HAVELLS.NS",
    "INDIGO.NS", "IOC.NS", "KOTAKBANK.NS", "ITC.NS", "VOLTAS.NS",
    "TECHM.NS", "HCL-INSYS.NS", "BIOCON.NS", "PEL.NS", "APOLLOTYRE.NS",
    "BATAINDIA.NS", "PIDILITIND.NS", "SBIN.NS", "AUROPHARMA.NS", "HINDUNILVR.NS",
]

# NYSE Stocks (Sample - expand as needed)
NYSE_STOCKS = [
    "AAPL", "MSFT", "GOOGL", "AMZN", "NVDA",
    "META", "TSLA", "BRK.B", "JNJ", "V",
    "WMT", "JPM", "PG", "MA", "INTC",
    "CSCO", "CMCSA", "PEP", "COST", "MCD",
    "ABD", "ADBE", "AMD", "AXP", "BA",
    "C", "CAT", "CRWD", "CRM", "DDOG",
    "ETN", "FANG", "GLD", "GS", "HD",
    "HUM", "IBM", "INTU", "JCI", "KO",
]

# Logging Configuration
LOG_LEVEL = os.getenv('LOG_LEVEL', 'INFO')
LOG_FORMAT = '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
