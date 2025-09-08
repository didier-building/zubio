# Chatwoot Technical Implementation Guide

## 1. Local Development Environment

### Prerequisites
- Ruby 3.4.x
- Node.js 20.x+
- PostgreSQL 16 with pgvector extension
- Redis 7.x
- Yarn or PNPM for package management

### Setup Using Docker (Recommended)
```bash
# Clone repository
git clone https://github.com/your-fork/chatwoot.git
cd chatwoot

# Run using docker-compose
docker-compose -f docker-compose.simple.yml up -d
```

### Manual Setup
```bash
# Install dependencies
bundle install
yarn install

# Configure environment
cp .env.example .env
# Edit .env with your configuration

# Setup database
bundle exec rails db:create
bundle exec rails db:setup

# Start servers
foreman start -f Procfile.dev
```

## 2. Core Module Overview

### Authentication System
- Located in `app/controllers/devise/`
- Uses Devise gem with custom JWT implementation
- Authentication flow defined in `app/controllers/api/v1/sessions_controller.rb`

### Conversation Management
- Core logic in `app/models/conversation.rb`
- Status transitions in `app/models/concerns/conversation_status_transition.rb`
- Assignment logic in `app/services/conversation_assignments_service.rb`

### Channel Integrations
- Base channel interface in `app/models/channel.rb`
- Channel-specific implementations in `app/models/channel/`
- Webhook handlers in `app/controllers/api/v1/webhooks/`

### Real-time Communication
- WebSocket implementation in `app/channels/`
- Action Cable configuration in `config/cable.yml`
- Client-side listeners in `app/javascript/dashboard/store/modules/pubsub.js`

## 3. API Documentation

### Authentication
```
POST /api/v1/accounts/:account_id/sessions
  - Email/password authentication
  - Returns auth_token

# All API requests require headers:
  - api_access_token: [user_access_token]
  - Authorization: Bearer [auth_token]
```

### Key Endpoints
- Conversations: `/api/v1/accounts/:account_id/conversations`
- Contacts: `/api/v1/accounts/:account_id/contacts`
- Messages: `/api/v1/accounts/:account_id/conversations/:conversation_id/messages`
- Inboxes: `/api/v1/accounts/:account_id/inboxes`
- Reporting: `/api/v1/accounts/:account_id/reports`

Full API documentation available at: `/swagger` endpoint when running locally

## 4. Frontend Architecture

### Vue.js Application Structure
- Entry point: `app/javascript/dashboard/App.vue`
- Router configuration: `app/javascript/dashboard/routes/index.js`
- Store (Vuex): `app/javascript/dashboard/store/`
- Components: `app/javascript/dashboard/components/`
- Mixins: `app/javascript/dashboard/mixins/`

### Key Components
- Conversation View: `app/javascript/dashboard/components/conversations/`
- Contact Panel: `app/javascript/dashboard/components/widgets/conversation/ContactPanel.vue`
- Settings Pages: `app/javascript/dashboard/routes/settings/`

### Widget Implementation
- Entry point: `app/javascript/widget/App.vue`
- Builder: `app/javascript/widget/builders/`
- SDK: `app/javascript/widget/sdk/`
- Store: `app/javascript/widget/store/`

## 5. Database Migration Guide

### Creating Migrations
```bash
bundle exec rails g migration AddFieldToModel field:type
bundle exec rails db:migrate
```

### Seeding Data
- Default seeds in `db/seeds.rb`
- Custom seeds can be added to `db/seeds/custom_seeds.rb`

### Managing Schema
- Schema file: `db/schema.rb`
- For complex migrations, use `change` method for automatic rollback support

## 6. Background Processing

### Sidekiq Jobs
- Job classes in `app/jobs/`
- Configuration in `config/sidekiq.yml`
- Web interface at `/sidekiq` (admin access)

### Common Jobs
- `ConversationReplyEmailWorker`: Send email notifications
- `WebhookJob`: Deliver webhooks to external systems
- `ReportingEvents::ConversationCreateJob`: Create reporting events

## 7. Testing

### RSpec Tests
- Models: `spec/models/`
- Controllers: `spec/controllers/`
- Services: `spec/services/`
- Running tests: `bundle exec rspec`

### Frontend Tests
- Component tests: `app/javascript/dashboard/components/__tests__/`
- Running tests: `yarn test`

## 8. Deployment Options

### Self-hosted Production
- Docker Compose: `docker-compose.production.yaml`
- Kubernetes: Helm charts available in `deployment/helm/`
- Requirements: 2GB RAM, 1 CPU core (minimum)

### Platform-as-a-Service
- Heroku deployment guide in `deployment/heroku/`
- AWS Elastic Beanstalk: `deployment/aws/`

### Scaling Considerations
- Redis ElastiCache for larger deployments
- PostgreSQL RDS with appropriate sizing
- Horizontal scaling of worker containers
- CDN for static assets
