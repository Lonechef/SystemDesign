-> So maintly we need to store the counter data that basically means we need to trach countn of each type of request that is currently made by users 
### Storage Calculation for Rate Limiting

To implement rate limiting, we need to track the count of requests per user per API. The storage required depends on the number of users and the number of APIs.

| Parameter                | Description                                 | Formula                                 |
|--------------------------|---------------------------------------------|-----------------------------------------|
| Number of Users          | Total unique users                          | `U`                                     |
| Number of APIs           | Total unique APIs                           | `A`                                     |
| Number of Entries        | One entry per user per API                  | `U * A`                                 |
| Size of Each Entry       | Memory required to store one counter        | `S` (in bytes)                          |
| **Total Storage Needed** | Total memory required for all counters      | `U * A * S` (in bytes)                  |

**Example:**  
If there are 1 million users, 100 APIs, and each entry takes 32 bytes:
- Number of entries = 1,000,000 * 100 = 100,000,000
- Total storage = 100,000,000 * 32 bytes = ~3.2 GB

> Note: Large storage requirements can be optimized using caching solutions like Redis or Memcached.