## Network Bandwidth Estimation

- This section discusses ingress and egress bandwidth estimation.
- Assume the combined size of each request and response is **1 kilobyte**.
- **Total data transferred per day** = Total Number of Requests per Day × Size of Each Request
    - Example: 500 million requests/day × 1 kilobyte/request = **50 TB/day**

---

## Storage Estimation for Rate Limiting

- For a given application, there are several APIs.
- If we want to apply rate limiting per user per API:
    - For example, User 1 calls API 1 four times, API 2 three times, etc.
    - Each API call by a user is tracked.
- **Number of entries required** = Total Number of APIs × Total Number of Users
- **Total storage required** = Number of Entries × Size of Each Entry
- This helps estimate the storage needed to maintain rate limiting data.