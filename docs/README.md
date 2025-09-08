# Chatwoot System Overview for Developers

Welcome to the Chatwoot documentation for developers! This guide provides a comprehensive overview of the system to help you understand its architecture, workflows, and technical implementation.

## 📚 Documentation Index

1. **[User Journeys](/docs/user_journeys.md)** - Detailed walkthrough of how different users interact with the system
2. **[Architecture Overview](/docs/architecture.md)** - High-level and detailed system architecture
3. **[Database Design](/docs/database_design.md)** - Database schema and relationships
4. **[User Personas](/docs/user_personas.md)** - Understanding the typical users of the system
5. **[Key Features](/docs/key_features.md)** - Overview of major functionality
6. **[Technical Implementation](/docs/technical_implementation.md)** - Development and deployment guidelines

## 🏛️ System Architecture at a Glance

Chatwoot is built as a Ruby on Rails 7.1 application with a Vue.js 3 frontend, using PostgreSQL 16 (with pgvector) for data storage and Redis for caching and background jobs.

```
┌─────────────────────────┐
│                         │
│  Vue.js Frontend (SPA)  │
│                         │
└───────────┬─────────────┘
            │
            │ REST API / WebSockets
            │
┌───────────▼─────────────┐     ┌─────────────────────┐
│                         │     │                     │
│  Rails Backend (API)    │◄────►  Background Workers │
│                         │     │  (Sidekiq)          │
└───────────┬─────────────┘     └─────────┬───────────┘
            │                             │
            │                             │
┌───────────▼─────────────┐     ┌─────────▼───────────┐
│                         │     │                     │
│  PostgreSQL Database    │     │  Redis              │
│  (with pgvector)        │     │                     │
└─────────────────────────┘     └─────────────────────┘
```

## 🔑 Key Concepts

### 1. Multi-tenancy
Chatwoot is designed as a multi-tenant system, where each **Account** represents an organization. All major resources (conversations, contacts, inboxes) are scoped to an account.

### 2. Omnichannel Support
The system unifies conversations from multiple channels (web chat, email, social media) into a single interface through the concept of **Inboxes**.

### 3. Conversation Management
**Conversations** are the core entity, representing a thread of communication between a customer and support agents, containing individual **Messages**.

### 4. Role-based Access
Users have different roles (admin, agent) with varying permissions within accounts, controlled through the **AccountUsers** relationship.

## 💻 Development Approach

### Getting Started
1. Review the [Technical Implementation Guide](/docs/technical_implementation.md)
2. Understand the [Database Design](/docs/database_design.md)
3. Explore the codebase structure focusing on models and controllers
4. Run the application using Docker as described in the implementation guide

### Key Files for Understanding the Codebase
- **Models**: `app/models/account.rb`, `app/models/conversation.rb`, `app/models/inbox.rb`
- **Controllers**: `app/controllers/api/v1/accounts/conversations_controller.rb`
- **Frontend**: `app/javascript/dashboard/App.vue`, `app/javascript/dashboard/store/index.js`

### Development Workflow
1. Use the Docker setup for consistent development environment
2. Follow TDD approach with RSpec for backend and Jest for frontend
3. Run linters before submitting code changes
4. Reference API documentation for integrating new features

## 🚀 Next Steps

1. **Run the application** locally using the provided Docker configuration
2. **Explore the UI** to understand the feature set from a user perspective
3. **Review the code** for key models and controllers
4. **Check the test suite** to understand expected behavior
5. **Create a simple feature** to get familiar with the development workflow

## 📌 Resources

- GitHub Repository: [chatwoot/chatwoot](https://github.com/chatwoot/chatwoot)
- Official Documentation: [chatwoot.com/docs](https://www.chatwoot.com/docs)
- API Reference: [chatwoot.com/developers/api](https://www.chatwoot.com/developers/api)
- Community Forums: [community.chatwoot.com](https://community.chatwoot.com)

---

This documentation was prepared for Zubio's implementation of Chatwoot.
