from flask import Flask, jsonify
from flask_cors import CORS
import logging
from screener_demo import DemoScreener
from cache import CacheManager

app = Flask(__name__)
CORS(app)

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

screener = DemoScreener()
cache_manager = CacheManager(ttl_seconds=30)

@app.route('/api/health', methods=['GET'])
def health_check():
    return jsonify({'status': 'healthy'}), 200

@app.route('/api/stocks/nse', methods=['GET'])
def get_nse_stocks():
    cache_key = 'nse_stocks'

    cached_result = cache_manager.get(cache_key)
    if cached_result is not None:
        logger.info("Returning cached NSE results")
        return jsonify({
            'market': 'NSE',
            'stocks': cached_result,
            'count': len(cached_result),
            'cached': True
        }), 200

    try:
        logger.info("Fetching fresh NSE stocks data...")
        results = screener.screen_nse()
        cache_manager.set(cache_key, results)

        return jsonify({
            'market': 'NSE',
            'stocks': results,
            'count': len(results),
            'cached': False
        }), 200

    except Exception as e:
        logger.error(f"Error screening NSE stocks: {str(e)}")
        return jsonify({
            'error': str(e),
            'market': 'NSE'
        }), 500

@app.route('/api/stocks/nyse', methods=['GET'])
def get_nyse_stocks():
    cache_key = 'nyse_stocks'

    cached_result = cache_manager.get(cache_key)
    if cached_result is not None:
        logger.info("Returning cached NYSE results")
        return jsonify({
            'market': 'NYSE',
            'stocks': cached_result,
            'count': len(cached_result),
            'cached': True
        }), 200

    try:
        logger.info("Fetching fresh NYSE stocks data...")
        results = screener.screen_nyse()
        cache_manager.set(cache_key, results)

        return jsonify({
            'market': 'NYSE',
            'stocks': results,
            'count': len(results),
            'cached': False
        }), 200

    except Exception as e:
        logger.error(f"Error screening NYSE stocks: {str(e)}")
        return jsonify({
            'error': str(e),
            'market': 'NYSE'
        }), 500

@app.route('/api/refresh', methods=['POST'])
def force_refresh():
    try:
        cache_manager.clear()
        logger.info("Cache cleared, forcing fresh data fetch")
        return jsonify({'status': 'cache cleared'}), 200
    except Exception as e:
        logger.error(f"Error clearing cache: {str(e)}")
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    import os
    port = int(os.getenv('PORT', 5000))
    logger.info(f"Starting Stock Screener Backend (DEMO) on port {port}...")
    app.run(debug=True, port=port, host='0.0.0.0')
