# Chatwoot Architecture Overview

## 1. High-Level Architecture

Chatwoot follows a standard Ruby on Rails application architecture with a Vue.js frontend, using a PostgreSQL database and Redis for caching and background job processing.

```
┌─────────────────┐     ┌───────────────┐     ┌─────────────────┐
│  Client Layer   │     │  Server Layer  │     │  Storage Layer  │
│  - Vue.js SPA   │ ←→  │  - Rails API   │ ←→  │  - PostgreSQL   │
│  - Chat Widget  │     │  - Sidekiq     │     │  - Redis        │
└─────────────────┘     └───────────────┘     └─────────────────┘
```

## 2. Backend Components

### Rails Application (app/)
- **Models** (`app/models/`): ActiveRecord models that represent database tables
- **Controllers** (`app/controllers/`): Process requests and return responses
- **Jobs** (`app/jobs/`): Background jobs processed by Sidekiq
- **Policies** (`app/policies/`): Authorization rules using Pundit
- **Services** (`app/services/`): Service objects for complex business logic
- **Mailers** (`app/mailers/`): Email templates and delivery logic
- **Views** (`app/views/`): ERB templates (primarily for emails as the frontend is Vue.js)

### Background Processing
- **Sidekiq** processes background jobs for:
  - Email delivery
  - Webhook delivery
  - Report generation
  - Conversation routing
  - Channel synchronization

### API Architecture
- RESTful API endpoints under `app/controllers/api/`
- Versioned APIs (currently v1, v2)
- JWT-based authentication
- Rate limiting and throttling

## 3. Frontend Architecture

### Vue.js SPA (`app/javascript/`)
- **Vue Router** for client-side routing
- **Vuex** for state management
- **Component-Based** architecture in `app/javascript/dashboard/components/`
- **API Clients** in `app/javascript/dashboard/api/`

### Chat Widget (`app/javascript/widget/`)
- Separate Vue.js application
- Loads asynchronously on customer websites
- Communicates with backend via WebSockets and REST API

## 4. Communication Channels

### Channel Integrations
- **WebWidgets**: JavaScript widget for websites
- **Facebook**: Integration via Facebook Messenger API
- **Twitter**: Integration via Twitter API
- **WhatsApp**: Integration via WhatsApp Business API
- **Email**: Two-way email communication
- **API**: Custom integrations via REST API

### Real-time Communication
- **Action Cable** (WebSockets) for real-time updates
- **Redis** pub/sub for broadcasting events

## 5. Database Architecture

### PostgreSQL
- Primary relational database
- pgvector extension for AI feature support

### Redis
- Caching layer
- Background job queues
- Session storage
- Real-time broadcast

## 6. External Dependencies

### Third-party Services
- **AWS S3** (optional): File storage
- **SendGrid/Mailgun** (optional): Email delivery
- **Twilio** (optional): SMS/WhatsApp
- **Various OAuth providers**: For social login

### AI Components
- **OpenAI/local embeddings**: For intelligent responses
- **pgvector**: Vector storage for semantic search

## 7. Deployment Architecture

### Docker-based Deployment
- Rails application container
- Sidekiq worker container
- PostgreSQL container
- Redis container
- Nginx for static asset serving (production)

## 8. Security Architecture

- **Pundit**: For authorization
- **Devise**: For authentication
- **JWT**: For API authentication
- **CORS**: Cross-Origin Resource Sharing policies
- **CSP**: Content Security Policies
- **Rate Limiting**: To prevent abuse
