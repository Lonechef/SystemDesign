
## High-Level Design: Online Presence Status

This document outlines how a messaging system like WhatsApp implements the "online" presence feature, allowing users to see when their contacts are actively using the app.

### Core Concepts

The online status feature is built around a persistent connection and a real-time notification system. The key components are:

*   **Persistent Connection:** Each client maintains an active WebSocket connection to a server.
*   **Presence Service:** A dedicated backend service to track and manage the online status of all users.
*   **In-Memory Cache:** A fast key-value store (like Redis) to quickly read and write user presence information.
*   **Heartbeat Mechanism:** A periodic signal to detect and handle abrupt disconnections.

### Step-by-Step Flow

1.  **Client Comes Online:**
    *   When a user opens the app, their client establishes a WebSocket connection with a **WebSocket Handler**.
    *   Upon successful connection, the client sends a `"PRESENCE_UPDATE: online"` event to the handler.
    *   The WebSocket Handler forwards this event to the **Presence Service**.
    *   The Presence Service updates the user's status in the **in-memory cache (e.g., Redis)**, setting their status to `"online"` with a current timestamp.

2.  **Notifying Contacts (Fan-out on Write):**
    *   The Presence Service fetches the contact list of the user who just came online.
    *   It then pushes a status update (`"USER_ID: online"`) to all *currently online* contacts in that list.
    *   This notification is sent via the respective WebSocket Handlers for each contact, allowing their UI to update in real-time.

3.  **Client Goes Offline:**
    *   **Graceful Disconnect:** When the user closes the app normally, the client sends a `"PRESENCE_UPDATE: offline"` event. The Presence Service updates the cache with a `"last_seen"` timestamp.
    *   **Ungraceful Disconnect (Heartbeat):** To handle unexpected connection drops (e.g., network loss, app crash), the client and server periodically exchange small "heartbeat" (ping/pong) messages. If the server doesn't receive a heartbeat from a client for a predefined timeout period (e.g., 60 seconds), it considers the client disconnected. The Presence Service is then notified to update the user's status to `"last_seen"` with the timestamp of the last successful heartbeat.

4.  **Checking Status on Demand (Fan-out on Read):**
    *   When a user opens a chat with another user, their client can also explicitly request the current status from the Presence Service to ensure it has the most up-to-date information. This is a secondary check to complement the real-time push notifications.

### Flowchart Representation

```mermaid
graph TD
    subgraph Client A (User)
        A[Opens App]
        A_CONN[Establishes WebSocket]
        A_HB[Sends Heartbeats]
    end

    subgraph Server Infrastructure
        WSH[WebSocket Handler]
        PS[Presence Service]
        CACHE[(Presence Cache - Redis)]
        DB[(User Contacts DB)]
    end

    subgraph Contacts
        C1[Contact 1 (Online)]
        C2[Contact 2 (Online)]
    end

    %% Online Flow
    A --> A_CONN
    A_CONN -- "PRESENCE: online" --> WSH
    WSH --> PS
    PS --> CACHE{Set User A: online}

    %% Fan-out to Contacts
    PS -- "Get Contacts" --> DB
    DB --> PS
    PS -- "Notify Contacts" --> C1
    PS -- "Notify Contacts" --> C2

    %% Heartbeat Flow
    A_HB <--> WSH
    WSH -- "Ping/Pong" --> PS
    PS -- "Update Timestamp" --> CACHE

    %% Timeout Flow
    WSH -- "No Heartbeat?" --> PS
    PS --> CACHE{Set User A: last_seen}

```
