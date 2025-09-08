# Chatwoot Database Design

## Core Tables

### Accounts
Represents an organization or business using Chatwoot.
```
accounts
├── id: bigint (PK)
├── name: string
├── domain: string (optional)
├── support_email: string
├── settings: jsonb (preferences, working hours, etc.)
├── feature_flags: jsonb
├── limits: jsonb
└── timestamps
```

### Users
People who use the system (admins, agents).
```
users
├── id: bigint (PK)
├── name: string
├── email: string
├── password_digest: string
├── reset_password_token: string
├── confirmation_token: string
├── access_token: string
├── availability_status: integer
├── custom_attributes: jsonb
└── timestamps
```

### Account Users
Join table between accounts and users (many-to-many).
```
account_users
├── id: bigint (PK)
├── account_id: bigint (FK)
├── user_id: bigint (FK)
├── role: integer (0: agent, 1: administrator)
├── availability_status: integer
└── timestamps
```

### Inboxes
Communication channels for conversations.
```
inboxes
├── id: bigint (PK)
├── account_id: bigint (FK)
├── channel_type: integer (website, facebook, twitter, etc.)
├── name: string
├── channel_id: bigint (polymorphic FK)
├── greeting_message: text
├── greeting_enabled: boolean
├── working_hours_enabled: boolean
├── enable_auto_assignment: boolean
├── out_of_office_message: text
└── timestamps
```

### Channel-specific Tables
```
channel_web_widgets
├── id: bigint (PK)
├── website_url: string
├── welcome_title: string
├── welcome_tagline: string
├── widget_color: string
├── hmac_token: string
└── timestamps

channel_facebook_pages
channel_twitter_profiles
channel_email_mailboxes
channel_twilio_sms
...
```

### Contacts
End-users/customers who communicate with the business.
```
contacts
├── id: bigint (PK)
├── account_id: bigint (FK)
├── name: string
├── email: string
├── phone_number: string
├── identifier: string (unique identifier)
├── custom_attributes: jsonb
├── additional_attributes: jsonb
└── timestamps
```

### Conversations
Threads of communication between contacts and agents.
```
conversations
├── id: bigint (PK)
├── account_id: bigint (FK)
├── inbox_id: bigint (FK)
├── contact_id: bigint (FK)
├── status: integer (open, resolved, pending, snoozed)
├── assignee_id: bigint (FK to users)
├── team_id: bigint (FK to teams)
├── priority: integer
├── display_id: integer
├── additional_attributes: jsonb
└── timestamps
```

### Messages
Individual messages within conversations.
```
messages
├── id: bigint (PK)
├── conversation_id: bigint (FK)
├── account_id: bigint (FK)
├── sender_type: string (polymorphic)
├── sender_id: bigint (polymorphic FK)
├── content: text
├── content_type: integer (text, image, video, file, etc.)
├── message_type: integer (incoming, outgoing)
├── source_id: string
├── content_attributes: jsonb
├── sender_attributes: jsonb
├── sentiment: jsonb
└── timestamps
```

### Teams
Groups of agents within an account.
```
teams
├── id: bigint (PK)
├── account_id: bigint (FK)
├── name: string
├── description: text
├── allow_auto_assign: boolean
└── timestamps
```

### Team Members
Join table between teams and users.
```
team_members
├── id: bigint (PK)
├── team_id: bigint (FK)
├── user_id: bigint (FK)
└── timestamps
```

## Feature-specific Tables

### Canned Responses
Pre-saved responses for common questions.
```
canned_responses
├── id: bigint (PK)
├── account_id: bigint (FK)
├── short_code: string
├── content: text
└── timestamps
```

### Labels
Tags to categorize conversations.
```
labels
├── id: bigint (PK)
├── account_id: bigint (FK)
├── title: string
├── description: text
├── color: string
└── timestamps
```

### Custom Attributes
Custom fields for contacts or conversations.
```
custom_attribute_definitions
├── id: bigint (PK)
├── account_id: bigint (FK)
├── attribute_model: string (Contact or Conversation)
├── attribute_key: string
├── attribute_display_name: string
├── attribute_description: text
├── attribute_display_type: integer (text, number, currency, etc.)
├── default_value: string
└── timestamps
```

### Automation Rules
Rules for automating conversation handling.
```
automation_rules
├── id: bigint (PK)
├── account_id: bigint (FK)
├── name: string
├── description: text
├── event_name: string
├── conditions: jsonb
├── actions: jsonb
└── timestamps
```

### Reports
```
reporting_events
├── id: bigint (PK)
├── account_id: bigint (FK)
├── conversation_id: bigint (FK)
├── user_id: bigint (FK)
├── event_type: string
├── value: float
├── value_in_business_hours: float
└── timestamps
```

## AI-Specific Tables

```
ai_conversation_embeddings
├── id: bigint (PK)
├── conversation_id: bigint (FK)
├── embedding: vector (pgvector)
└── timestamps

ai_message_embeddings
├── id: bigint (PK)
├── message_id: bigint (FK)
├── embedding: vector (pgvector)
└── timestamps
```

## Key Relations

- An **Account** has many **Users** through **AccountUsers**
- An **Account** has many **Inboxes**
- An **Inbox** has one **Channel** (polymorphic)
- An **Inbox** has many **Conversations**
- A **Conversation** has many **Messages**
- A **Conversation** belongs to a **Contact**
- A **User** can be assigned to many **Conversations**
- A **Team** has many **Users** through **TeamMembers**
