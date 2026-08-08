import time
from typing import Any, Optional

class CacheManager:
    def __init__(self, ttl_seconds: int = 30):
        self.ttl_seconds = ttl_seconds
        self.cache = {}
        self.timestamps = {}

    def get(self, key: str) -> Optional[Any]:
        if key not in self.cache:
            return None

        if time.time() - self.timestamps[key] > self.ttl_seconds:
            del self.cache[key]
            del self.timestamps[key]
            return None

        return self.cache[key]

    def set(self, key: str, value: Any) -> None:
        self.cache[key] = value
        self.timestamps[key] = time.time()

    def clear(self, key: str = None) -> None:
        if key:
            self.cache.pop(key, None)
            self.timestamps.pop(key, None)
        else:
            self.cache.clear()
            self.timestamps.clear()

    def is_expired(self, key: str) -> bool:
        if key not in self.cache:
            return True
        return time.time() - self.timestamps[key] > self.ttl_seconds
