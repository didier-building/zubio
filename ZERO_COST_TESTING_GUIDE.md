# Zero-Cost Feature Testing Guide
## Test Every Chatwoot Feature Without Spending Money

**Current Setup:**
- URL: http://localhost:3000
- Admin: admin@zubio.com / Admin123!

---

## 🎯 Quick Start: 5-Minute Setup

### Step 1: Create Test Users (Different Roles)

**Login as Admin** → Go to: http://localhost:3000/app/accounts/1/settings/agents/list

**Create these users:**

1. **Agent 1 (Sales Team)**
   - Name: Sarah Sales
   - Email: sarah@zubio.com
   - Role: Agent
   - Password: Test123!

2. **Agent 2 (Support Team)**
   - Name: Sam Support
   - Email: sam@zubio.com
   - Role: Agent
   - Password: Test123!

3. **Manager**
   - Name: Mike Manager
   - Email: mike@zubio.com
   - Role: Administrator
   - Password: Test123!

**Why:** Test how different users see different things, assign conversations, collaborate.

---

## 📱 Feature 1: Website Chat Widget (FREE - Most Important!)

### Setup (5 minutes):

1. **Create Inbox:**
   - Go to: Settings → Inboxes → Add Inbox
   - Choose: Website
   - Name: "Main Website"
   - Website Domain: http://localhost:3000
   - Click Create

2. **Get Widget Code:**
   - After creating, copy the widget installation code
   - It looks like:
   ```html
   <script>
     (function(d,t) {
       var BASE_URL="http://localhost:3000";
       var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
       g.src=BASE_URL+"/packs/js/sdk.js";
       s.parentNode.insertBefore(g,s);
       g.async=!0;
       g.onload=function(){
         window.chatwootSDK.run({
           websiteToken: 'YOUR_TOKEN_HERE',
           baseUrl: BASE_URL
         })
       };
     })(document,"script");
   </script>
   ```

3. **Test It:**
   - Create a simple HTML file to test:
   ```bash
   # Run this in terminal:
   cat > /tmp/test-widget.html << 'EOF'
   <!DOCTYPE html>
   <html>
   <head>
       <title>Test Chatwoot Widget</title>
   </head>
   <body>
       <h1>Test Page - Look for chat bubble in bottom right!</h1>
       
       <!-- PASTE YOUR WIDGET CODE HERE -->
       <script>
         (function(d,t) {
           var BASE_URL="http://localhost:3000";
           var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
           g.src=BASE_URL+"/packs/js/sdk.js";
           s.parentNode.insertBefore(g,s);
           g.async=!0;
           g.onload=function(){
             window.chatwootSDK.run({
               websiteToken: 'PASTE_YOUR_TOKEN_HERE',
               baseUrl: BASE_URL
             })
           };
         })(document,"script");
       </script>
   </body>
   </html>
   EOF
   
   # Open in browser
   xdg-open /tmp/test-widget.html
   ```

4. **Customize Widget:**
   - Settings → Inboxes → Main Website → Settings
   - **Customize:**
     - Widget Color
     - Welcome message: "Hi! How can we help you today? 😊"
     - Pre-chat form (Name, Email, Phone)
     - Widget position (Left/Right)
     - Away message

### What to Test:

✅ **As Customer (test-widget.html):**
- [ ] Send a message
- [ ] See typing indicator
- [ ] Receive reply
- [ ] Send attachment
- [ ] Rate conversation

✅ **As Agent (Chatwoot dashboard):**
- [ ] See incoming message notification
- [ ] Reply to customer
- [ ] See customer typing
- [ ] Send attachment
- [ ] View contact info

---

## 📧 Feature 2: Email Inbox (FREE - Use MailHog)

**Good News:** Your Docker setup already includes MailHog!

### Setup (2 minutes):

1. **Access MailHog:**
   - Open: http://localhost:8025
   - This catches all emails sent by Chatwoot

2. **Create Email Inbox:**
   - Settings → Inboxes → Add Inbox
   - Choose: Email
   - Email: support@localhost
   - IMAP: (Leave disabled for testing)
   - SMTP Settings:
     - Address: mailhog
     - Port: 1025
     - Email: support@localhost
     - (No password needed)
   - Click Create

3. **Test Sending Email:**
   - In Chatwoot, create a conversation
   - Send a message
   - Check MailHog (http://localhost:8025) to see the email

### What to Test:

✅ **Email Features:**
- [ ] Send email from Chatwoot
- [ ] See email in MailHog
- [ ] Email templates work
- [ ] Attachments in email
- [ ] Email notifications

---

## 👥 Feature 3: Teams (FREE)

### Setup (3 minutes):

1. **Create Teams:**
   - Settings → Teams → Add Team
   
   **Create these teams:**
   - Sales Team (Assign: Sarah)
   - Support Team (Assign: Sam)
   - Management (Assign: Mike)

2. **Configure Team Assignments:**
   - Settings → Inboxes → Main Website
   - Go to: Collaborators tab
   - Assign teams to inbox

### What to Test:

✅ **Team Features:**
- [ ] Create conversation
- [ ] Assign to team
- [ ] Team members see it
- [ ] Team-based filtering
- [ ] Team reports
- [ ] Team mentions in private notes

---

## 🤖 Feature 4: Automation Rules (FREE - Most Impressive!)

### Setup (10 minutes):

**Create these automation rules to demonstrate power:**

#### Rule 1: Auto-Greeting
- Settings → Automation → Add Rule
- **Event:** Conversation Created
- **Conditions:** Inbox equals "Main Website"
- **Actions:**
  - Send message: "Thanks for contacting us! An agent will be with you shortly. 😊"
  - Add label: "New"

#### Rule 2: Business Hours Auto-Reply
- **Event:** Conversation Created
- **Conditions:** 
  - Inbox equals "Main Website"
  - Hour is between 18:00 and 09:00
- **Actions:**
  - Send message: "Thanks for your message! Our business hours are 9 AM - 6 PM. We'll respond when we're back online."
  - Add label: "After Hours"

#### Rule 3: Auto-Assignment by Keyword
- **Event:** Message Created
- **Conditions:**
  - Message contains "price" OR "pricing" OR "cost"
- **Actions:**
  - Assign conversation to: Sarah (Sales agent)
  - Add label: "Pricing Inquiry"
  - Add private note: "@sarah This customer is asking about pricing"

#### Rule 4: Priority Escalation
- **Event:** Conversation Created
- **Conditions:**
  - Message contains "urgent" OR "emergency" OR "ASAP"
- **Actions:**
  - Assign conversation to: Mike (Manager)
  - Add label: "Urgent"
  - Send message: "We've flagged this as urgent and notified our team lead."

#### Rule 5: Auto-Close After Resolution
- **Event:** Message Created
- **Conditions:**
  - Message contains "thank you" OR "resolved" OR "fixed"
  - Conversation status equals "Open"
- **Actions:**
  - Resolve conversation
  - Add label: "Resolved"

### What to Test:

✅ **Automation Features:**
- [ ] Send message with "price" → Auto-assigns to Sarah
- [ ] Send message after 6 PM → Auto-reply
- [ ] Send message with "urgent" → Escalates to manager
- [ ] New conversation → Gets welcome message
- [ ] Reply "thank you" → Auto-closes conversation

---

## 📝 Feature 5: Canned Responses (FREE)

### Setup (5 minutes):

**Create these canned responses:**

#### Response 1: Business Hours
- Short Code: `/hours`
- Content:
```
Our business hours are:
Monday - Friday: 9 AM - 6 PM
Saturday: 10 AM - 2 PM
Sunday: Closed

We'll respond to your message during our next business hours. Thank you for your patience! 🙏
```

#### Response 2: Pricing Info
- Short Code: `/pricing`
- Content:
```
Thank you for your interest in our services! 

Our pricing plans are:
• Starter: $29/month - Perfect for small teams
• Professional: $79/month - For growing businesses
• Enterprise: Custom pricing - For large organizations

Which plan would you like to know more about?
```

#### Response 3: Appointment Request
- Short Code: `/appointment`
- Content:
```
I'd be happy to help you schedule an appointment! 

Please provide:
1. Preferred date and time
2. Type of service you need
3. Any specific requirements

I'll check availability and confirm within 30 minutes. 📅
```

#### Response 4: Technical Support
- Short Code: `/tech`
- Content:
```
I'm here to help with your technical issue! 

To assist you better, please provide:
1. What exactly is happening?
2. What steps have you already tried?
3. What device/browser are you using?

Screenshots are helpful if possible! 📸
```

#### Response 5: Thank You
- Short Code: `/thanks`
- Content:
```
Thank you for contacting us! 

Your satisfaction is our priority. If you need anything else, just send us a message.

Have a wonderful day! ☀️
```

### What to Test:

✅ **Canned Response Features:**
- [ ] Type `/` to see list
- [ ] Use `/hours` in conversation
- [ ] Quick insert saves time
- [ ] Edit canned response
- [ ] Create custom ones
- [ ] Use in different conversations

---

## 🏷️ Feature 6: Labels & Organization (FREE)

### Setup (3 minutes):

**Create these labels:**

1. **Priority Labels:**
   - Urgent (Red)
   - High Priority (Orange)
   - Normal (Blue)
   - Low Priority (Gray)

2. **Category Labels:**
   - Sales Inquiry
   - Support Request
   - Billing Question
   - Feature Request
   - Bug Report
   - Appointment

3. **Status Labels:**
   - New
   - In Progress
   - Waiting on Customer
   - Resolved
   - After Hours

### What to Test:

✅ **Label Features:**
- [ ] Add label to conversation
- [ ] Filter by label
- [ ] Multiple labels per conversation
- [ ] Color coding visible
- [ ] Label-based reports
- [ ] Auto-labeling (via automation)

---

## 📊 Feature 7: Reports & Analytics (FREE)

### Setup: Generate Test Data First

**Quick way to create test conversations:**

```bash
# Run this in terminal to create sample data:
docker-compose exec rails bundle exec rails runner "
account = Account.first
inbox = account.inboxes.first
user = account.users.first

# Create 10 test conversations
10.times do |i|
  contact = account.contacts.create!(
    name: \"Test Customer #{i+1}\",
    email: \"customer#{i+1}@test.com\"
  )
  
  conversation = account.conversations.create!(
    inbox: inbox,
    contact: contact,
    status: ['open', 'resolved'].sample,
    assignee: [user, nil].sample
  )
  
  # Add messages
  conversation.messages.create!(
    account: account,
    inbox: inbox,
    message_type: 'incoming',
    content: 'Hi, I need help with something',
    sender: contact
  )
  
  conversation.messages.create!(
    account: account,
    inbox: inbox,
    message_type: 'outgoing',
    content: 'Sure, I can help you with that!',
    sender: user
  )
end

puts '10 test conversations created!'
"
```

### What to Test:

✅ **Reports to Explore:**

1. **Overview Report:**
   - Go to: Reports → Overview
   - See: Total conversations, Response time, Resolution time
   - Filter by: Date range, Agent, Inbox

2. **Agent Report:**
   - Reports → Agents
   - See: Individual performance
   - Compare: Sarah vs Sam vs Mike

3. **Label Report:**
   - Reports → Labels
   - See: Most common issues
   - Identify: Trending topics

4. **Inbox Report:**
   - Reports → Inboxes
   - See: Performance by channel
   - Compare: Website vs Email

5. **Team Report:**
   - Reports → Teams
   - See: Team performance
   - Compare: Sales vs Support

---

## 💬 Feature 8: Conversations & Collaboration (FREE)

### What to Test:

✅ **Conversation Features:**

1. **Open Widget (as Customer):**
   - Send: "I need help with pricing"
   - Send an emoji: 😊
   - Try to send file (image)

2. **As Agent (Sarah):**
   - Reply to customer
   - Use canned response: `/pricing`
   - Add private note: "@mike Can you approve this discount?"
   - Add label: "Sales Inquiry"
   - Change status: Open → Resolved

3. **As Manager (Mike):**
   - See private note mention
   - Reply in private note
   - View conversation history
   - Reassign if needed

4. **Multi-Agent Chat:**
   - Have Sarah and Sam both open same conversation
   - Sarah types → Sam sees "typing indicator"
   - Both can add private notes
   - Shows who's viewing conversation

---

## 🔔 Feature 9: Notifications (FREE)

### Setup (2 minutes):

1. **Configure Notification Settings:**
   - Each agent: Profile → Notifications
   - Enable:
     - Email notifications
     - Browser notifications (allow in browser)
     - Push notifications

2. **Test Scenarios:**
   - Mention agent in private note: `@sarah`
   - Assign conversation to agent
   - New conversation arrives
   - Customer replies

### What to Test:

✅ **Notification Features:**
- [ ] Email notification received (check MailHog)
- [ ] Browser notification pops up
- [ ] Sound notification plays
- [ ] Notification badge on conversations
- [ ] Mention notifications work
- [ ] Assignment notifications work

---

## 👤 Feature 10: Contact Management (FREE CRM)

### Setup (5 minutes):

**Create Custom Contact Attributes:**

1. **Go to:** Settings → Custom Attributes
2. **Add Attributes:**

   - **For B2B:**
     - Company Name (Text)
     - Industry (Text)
     - Deal Size (Number)
     - Lead Source (Text)
   
   - **For Clinics:**
     - Patient ID (Text)
     - Date of Birth (Date)
     - Insurance Provider (Text)
     - Last Visit (Date)

### What to Test:

✅ **Contact Features:**

1. **Create Contact:**
   - Contacts → Add Contact
   - Add: Name, Email, Phone
   - Add custom attributes
   - Add social profiles

2. **Contact Timeline:**
   - View all conversations
   - See activity history
   - Notes about customer
   - Previous purchases/visits

3. **Contact Segments:**
   - Filter contacts by attributes
   - Export contact list
   - Import contacts (CSV)

4. **Merge Contacts:**
   - Create duplicate contact
   - Merge them together
   - See combined history

---

## 🎨 Feature 11: Branding & Customization (FREE)

### Setup (10 minutes):

#### 1. Account Branding
- Settings → Account Settings
- **Customize:**
  - Account name: "Zubio Support"
  - Site language
  - Timezone
  - Support email: support@zubio.com

#### 2. Widget Customization
- Settings → Inboxes → Main Website → Settings
- **Widget Appearance:**
  - Color: Choose your brand color
  - Position: Right/Left
  - Widget Type: Standard/Expanded
  
- **Welcome Messages:**
  - Online: "Hi there! 👋 How can we help?"
  - Offline: "We're away right now. Leave a message!"
  - Pre-chat message: "Please share your contact info"

#### 3. Pre-Chat Form
- Enable pre-chat form
- **Collect:**
  - Name (Required)
  - Email (Required)
  - Phone (Optional)
  - Company (Optional)

#### 4. Business Hours
- Settings → Inboxes → Main Website → Business Hours
- **Set Hours:**
  - Monday-Friday: 9:00 AM - 6:00 PM
  - Saturday: 10:00 AM - 2:00 PM
  - Sunday: Closed
- **Timezone:** Your timezone

### What to Test:

✅ **Branding Features:**
- [ ] Widget shows custom color
- [ ] Welcome message displays
- [ ] Pre-chat form appears
- [ ] After hours message shows
- [ ] Logo visible (if uploaded)
- [ ] Consistent branding across platform

---

## 📱 Feature 12: Mobile Testing (FREE)

### How to Test on Phone:

1. **Find Your Local IP:**
   ```bash
   ip addr show | grep "inet " | grep -v 127.0.0.1
   ```
   Example: 192.168.1.100

2. **Update Widget Test File:**
   - Edit `/tmp/test-widget.html`
   - Change: `http://localhost:3000` → `http://192.168.1.100:3000`

3. **Open on Phone:**
   - Make sure phone is on same WiFi
   - Open: `http://192.168.1.100:3000/app/login`
   - Or open test widget file on phone

### What to Test:

✅ **Mobile Features:**
- [ ] Login on phone works
- [ ] Dashboard is responsive
- [ ] Can reply to conversations
- [ ] Push notifications (if enabled)
- [ ] Widget on mobile browser
- [ ] Touch gestures work
- [ ] Camera/file upload from phone

---

## 🔐 Feature 13: Roles & Permissions (FREE)

### What to Test:

**Login as different users and compare:**

#### As Administrator (admin@zubio.com):
- ✅ Can access Settings
- ✅ Can create agents
- ✅ Can create inboxes
- ✅ Can see all reports
- ✅ Can delete conversations
- ✅ Full access to everything

#### As Agent (sarah@zubio.com):
- ✅ Can handle conversations
- ✅ Can see assigned conversations
- ✅ Can use canned responses
- ✅ Can add labels
- ❌ Cannot access Settings
- ❌ Cannot create agents
- ❌ Cannot see full reports

### Security Features to Test:
- [ ] Password change
- [ ] Profile settings
- [ ] Logout from all devices
- [ ] Session timeout
- [ ] Access control works

---

## 🎯 Feature 14: CSAT (Customer Satisfaction) (FREE)

### Setup (3 minutes):

1. **Enable CSAT:**
   - Settings → Inboxes → Main Website → Configuration
   - Enable: "Customer satisfaction survey"
   - Message: "How would you rate your conversation?"

2. **Test CSAT:**
   - Resolve a conversation (as agent)
   - Customer sees rating prompt
   - Customer rates: 😊 😐 😞
   - Customer leaves feedback (optional)

3. **View CSAT Reports:**
   - Reports → CSAT
   - See satisfaction scores
   - Read customer feedback
   - Filter by agent/time

### What to Test:

✅ **CSAT Features:**
- [ ] Survey shows after resolution
- [ ] Customer can rate
- [ ] Feedback submitted
- [ ] Reports show scores
- [ ] Can filter by rating
- [ ] Agent performance visible

---

## 🔍 Feature 15: Conversation Search & Filters (FREE)

### What to Test:

**Go to:** Conversations

✅ **Search Capabilities:**
- [ ] Search by customer name
- [ ] Search by email
- [ ] Search message content
- [ ] Search by label
- [ ] Search by date range

✅ **Filters:**
- [ ] Filter by: Mine/Unassigned/All
- [ ] Filter by: Open/Resolved/Pending
- [ ] Filter by: Inbox
- [ ] Filter by: Team
- [ ] Filter by: Label
- [ ] Combine multiple filters

✅ **Sorting:**
- [ ] Sort by: Latest
- [ ] Sort by: Waiting longest
- [ ] Sort by: Priority

---

## 🎬 Complete Testing Workflow (30 Minutes)

### Follow this flow to test everything:

**Minute 0-5: Setup**
1. Create 3 test users (Sarah, Sam, Mike)
2. Create 2 teams (Sales, Support)
3. Create website inbox

**Minute 5-10: Widget Testing**
1. Open widget in test HTML
2. Send message: "I need help with pricing"
3. See auto-greeting arrive
4. Agent Sarah receives notification

**Minute 10-15: Agent Response**
1. Login as Sarah
2. See conversation appear
3. Use canned response: `/pricing`
4. Add label: "Sales Inquiry"
5. Add private note: "@mike Please review"

**Minute 15-20: Collaboration**
1. Login as Mike (new browser/incognito)
2. See private note mention
3. Reply in private note
4. View conversation history
5. Monitor from dashboard

**Minute 20-25: Automation**
1. Send new message with "urgent"
2. Watch auto-assignment to Mike
3. See label auto-applied
4. Test business hours rule
5. Verify all automation works

**Minute 25-30: Reports**
1. Check Overview report
2. View Agent performance
3. See Label statistics
4. Export report data
5. Share findings

---

## 📊 Test Results Checklist

After testing, verify these work:

### Core Features ✅
- [ ] Website chat widget works
- [ ] Real-time messaging
- [ ] Notifications arrive
- [ ] Multiple agents can collaborate
- [ ] Conversations can be assigned

### Organization ✅
- [ ] Teams function properly
- [ ] Labels organize conversations
- [ ] Filters help find conversations
- [ ] Search works accurately
- [ ] Contact info saves

### Automation ✅
- [ ] Auto-greeting sends
- [ ] Auto-assignment works
- [ ] Business hours rules trigger
- [ ] Labels auto-apply
- [ ] Escalation rules fire

### Management ✅
- [ ] Reports show data
- [ ] CSAT collects feedback
- [ ] Different roles have different access
- [ ] Email notifications work
- [ ] Activity logs record actions

### Customization ✅
- [ ] Widget customization works
- [ ] Brand colors apply
- [ ] Welcome messages display
- [ ] Business hours respected
- [ ] Pre-chat form collects info

---

## 🚀 Demo-Ready Checklist

Before showing to a client:

- [ ] 10+ test conversations created
- [ ] All 3 test users created
- [ ] 5+ canned responses created
- [ ] 3+ automation rules active
- [ ] Widget customized with brand colors
- [ ] Labels created and organized
- [ ] Teams configured
- [ ] Reports showing data
- [ ] CSAT enabled
- [ ] Business hours set

---

## 💡 Pro Tips for Testing

1. **Use Multiple Browsers:**
   - Chrome: Admin
   - Firefox: Agent 1
   - Safari/Edge: Agent 2
   - Incognito: Customer

2. **Test Real Scenarios:**
   - "Customer asks about pricing" → Sales team
   - "Customer reports bug" → Support team
   - "Customer says urgent" → Manager

3. **Show Real-Time:**
   - Type in widget → Agent sees typing
   - Agent replies → Customer sees instantly
   - Add label → Updates immediately

4. **Create Realistic Data:**
   - Use real-sounding names
   - Actual questions customers would ask
   - Mix of resolved and open conversations

5. **Practice the Flow:**
   - Run through full workflow 3 times
   - Time yourself (should be < 5 minutes)
   - Get comfortable with interface

---

## 🎓 Training Your Team (Zero Cost)

### Day 1: Basics (2 hours)
1. Login and navigation
2. Handling conversations
3. Using canned responses
4. Adding labels
5. Assigning conversations

### Day 2: Advanced (2 hours)
1. Private notes and mentions
2. Contact management
3. Using filters and search
4. Understanding reports
5. Best practices

### Day 3: Practice (2 hours)
1. Role-play scenarios
2. Handle test conversations
3. Use all features
4. Ask questions
5. Get certified

---

## 📞 What to Tell Clients

**"Everything you're seeing works right now. No paid services required."**

- ✅ Website chat: FREE
- ✅ Unlimited agents: FREE
- ✅ Unlimited conversations: FREE
- ✅ All features: FREE
- ✅ Automation: FREE
- ✅ Reports: FREE
- ✅ Mobile apps: FREE

**"The only cost is hosting ($5-20/month) or use our hosting service."**

---

## 🎯 Next Steps After Testing

Once you've tested everything:

1. **Document what works:** Make notes
2. **Create your pitch:** Based on what impressed you
3. **Record demo video:** Show the flow
4. **Create pricing:** Based on hosting costs
5. **Start selling:** Book first demo!

---

## ⚡ Quick Commands Cheat Sheet

```bash
# Check if everything is running
docker-compose ps

# View Rails logs
docker-compose logs --tail 50 rails

# View Vite logs
docker-compose logs --tail 50 vite

# Restart services
docker-compose restart

# Create test data
docker-compose exec rails bundle exec rails runner "path/to/script.rb"

# Access Rails console
docker-compose exec rails bundle exec rails c

# Stop everything
docker-compose down

# Start everything
docker-compose up -d
```

---

## 🎉 You're Ready!

You now have a fully functional Chatwoot instance with:
- ✅ Multiple users and roles
- ✅ Website chat widget
- ✅ Email integration (MailHog)
- ✅ Automation rules
- ✅ Canned responses
- ✅ Labels and organization
- ✅ Teams and collaboration
- ✅ Reports and analytics
- ✅ CSAT surveys
- ✅ Full customization

**Total Cost: $0.00**

**Now go test everything and prepare your demo! 🚀**

---

## 📚 Additional Resources

- Main Sales Guide: `SALES_TOUR_GUIDE.md`
- Technical Docs: `docs/` folder
- Chatwoot Documentation: https://chatwoot.com/docs

**Questions? Test something that doesn't work? Let me know!**
