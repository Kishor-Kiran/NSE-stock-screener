import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:5000';

const api = axios.create({
  baseURL: API_URL,
  timeout: 30000,
});

export const getStocks = async (market) => {
  try {
    const endpoint = market === 'NSE' ? '/api/stocks/nse' : '/api/stocks/nyse';
    const response = await api.get(endpoint);
    return response.data;
  } catch (error) {
    console.error(`Error fetching ${market} stocks:`, error);
    throw error;
  }
};

export const refreshCache = async () => {
  try {
    const response = await api.post('/api/refresh');
    return response.data;
  } catch (error) {
    console.error('Error refreshing cache:', error);
    throw error;
  }
};

export const healthCheck = async () => {
  try {
    const response = await api.get('/api/health');
    return response.data;
  } catch (error) {
    console.error('Health check failed:', error);
    throw error;
  }
};

export default api;
