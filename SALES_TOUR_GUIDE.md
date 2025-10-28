# Chatwoot Sales Tour Guide
## Complete Guide for Selling Chatwoot to Businesses & Clinics

**Login Credentials:**
- URL: http://localhost:3000/app/login
- Email: admin@zubio.com
- Password: Admin123!

---

## 🎯 Pre-Demo Preparation Checklist

Before showing the demo:
1. ✅ Have a clear understanding of the client's pain points
2. ✅ Prepare sample data (contacts, conversations, canned responses)
3. ✅ Set up at least 2 channels (Website Widget + WhatsApp/Email)
4. ✅ Configure business hours
5. ✅ Create team structure with roles
6. ✅ Set up automation rules for common scenarios

---

## 📱 SECTION 1: Dashboard Overview (First Impression)

### What to Show:
**URL:** `http://localhost:3000/app/accounts/1/dashboard`

**Key Features to Highlight:**

1. **Unified Inbox**
   - "See ALL customer conversations from different channels in ONE place"
   - Point out: Email, WhatsApp, Facebook, Instagram, Twitter, Website Chat, Telegram
   - Emphasize: "Your team doesn't need to switch between 5 different apps"

2. **Real-Time Metrics**
   - Conversations Today
   - Open Conversations
   - Response Time
   - Resolution Time
   - First Response Time

3. **Team Performance**
   - Who's online
   - Who's handling what
   - Load distribution

### Sales Pitch Points:
- "Your current setup probably has your team juggling WhatsApp on phones, emails on desktop, Facebook messages somewhere else..."
- "With Chatwoot, everything comes to ONE screen"
- "Managers can see team performance in real-time"

---

## 💬 SECTION 2: Conversations (The Core Feature)

### What to Show:
**URL:** `http://localhost:3000/app/accounts/1/conversations`

**Demo Flow:**

1. **Open a Conversation**
   - Show the clean interface
   - Point out contact details on right sidebar
   - Demonstrate quick response

2. **Key Features to Demo:**
   
   a) **Canned Responses** (Ctrl + /)
   - "Imagine typing the same answer 50 times a day..."
   - Show: Create canned response for common questions
   - Example: "What are your business hours?"
   - Demonstrate: Type `/` and shortcut appears
   
   b) **Private Notes**
   - "Team members can discuss internally without customer seeing"
   - Use case: "Check with doctor" or "Verify insurance"
   - Show how to add private note with @ mention
   
   c) **Assignment**
   - Assign conversation to specific team member
   - Show team collaboration
   
   d) **Labels**
   - Organize conversations (Urgent, Billing, Appointment, etc.)
   - Filter and report by labels
   
   e) **Contact Information Panel**
   - All customer history in one place
   - Previous conversations
   - Custom attributes (Patient ID, Insurance Info, etc.)
   - Social media profiles

### Sales Pitch Points:
- **For Clinics:** "When a patient messages about an appointment, you see their full history, previous visits, allergies - all on the right side"
- **For Businesses:** "Your sales team can see previous purchases, support tickets, everything about this customer instantly"
- "No more asking 'Did you already talk to someone about this?'"

---

## 👥 SECTION 3: Contacts (CRM Features)

### What to Show:
**URL:** `http://localhost:3000/app/accounts/1/contacts`

**Key Features:**

1. **Unified Contact Database**
   - All customer information in one place
   - Merges from all channels (email, phone, social media)

2. **Custom Attributes**
   - Demo: Add custom fields specific to their business
   - **For Clinics:** Patient ID, Insurance Provider, Allergies, Last Visit
   - **For Businesses:** Company Name, Deal Size, Industry, Last Purchase

3. **Conversation History**
   - See all past interactions
   - Timeline of engagement

4. **Import/Export**
   - "You can import your existing customer database"
   - CSV import feature

### Sales Pitch Points:
- "This is your built-in CRM - no need to pay for Salesforce or HubSpot separately"
- "Every interaction is logged automatically"
- **For Clinics:** "HIPAA-compliant patient records management" (if you've configured it)

---

## 📊 SECTION 4: Reports (Decision-Maker Feature)

### What to Show:
**URL:** `http://localhost:3000/app/accounts/1/reports`

**Reports to Demonstrate:**

1. **Conversations Report**
   - Total conversations
   - Open vs Resolved
   - Response times
   - Resolution times
   - Filter by date, team, labels

2. **Agent Reports**
   - Individual performance
   - Who's most productive
   - Response time per agent
   - Resolution rate

3. **Label Reports**
   - Which issues are most common
   - Billing questions, Appointments, Technical support

4. **Inbox Reports**
   - Performance by channel
   - Which channels get most traffic

5. **CSAT (Customer Satisfaction)**
   - Survey results after conversations
   - Happy vs unhappy customers
   - Feedback analysis

### Sales Pitch Points:
- "Your managers need data to make decisions"
- "See which team members need training"
- "Identify bottlenecks in your support process"
- "Prove ROI - show how response times improved"
- **For Clinics:** "See peak hours for staffing decisions"

---

## 🔌 SECTION 5: Inboxes (Multi-Channel Setup)

### What to Show:
**URL:** `http://localhost:3000/app/accounts/1/settings/inboxes`

**Channels to Demonstrate:**

1. **Website Widget** (Most Important for Demo)
   - Show live chat bubble on their website
   - Customizable colors, position, greeting
   - Pre-chat form to collect info
   - Business hours support
   - **Demo this LIVE:** Open your website with widget

2. **WhatsApp Business API**
   - "Your clinic/business probably uses WhatsApp already"
   - Show how messages come into Chatwoot
   - Templates for appointment reminders
   - Auto-replies

3. **Email**
   - Support@yourcompany.com goes into Chatwoot
   - Team can respond from interface
   - Full email threading

4. **Facebook Messenger**
   - Connect Facebook page
   - Respond to FB messages without opening Facebook

5. **Instagram DM**
   - Handle Instagram messages professionally

6. **SMS/Twilio**
   - Send and receive SMS
   - **For Clinics:** Appointment reminders, test results

### Sales Pitch Points:
- "You pick which channels to activate - start small"
- "Most businesses start with Website Chat + WhatsApp"
- "Add channels as you grow, no extra cost"
- **For Clinics:** "Patients can reach you however they prefer"

---

## 🤖 SECTION 6: Automation (Time-Saver Feature)

### What to Show:
**URL:** `http://localhost:3000/app/accounts/1/settings/automation`

**Automation Rules to Demo:**

1. **Auto-Assignment**
   - "When conversation contains 'appointment' → Assign to receptionist"
   - "When conversation contains 'billing' → Assign to billing team"
   - Round-robin assignment to distribute load

2. **Auto-Labeling**
   - Automatically tag conversations based on keywords
   - Example: "insurance" → Add label "Insurance Query"

3. **Auto-Response**
   - After business hours → "We'll respond tomorrow at 9 AM"
   - First message → "Thanks for contacting us, someone will respond soon"

4. **SLA Automation**
   - "If conversation not responded to in 15 minutes → Notify manager"
   - "If conversation open for 24 hours → Escalate"

### Demo Setup Examples:

**For Clinics:**
```
Rule 1: New Appointment Request
When: Message contains "appointment"
Then: 
  - Assign to: Reception Team
  - Add label: Appointment
  - Send message: "I'll help you schedule an appointment..."
```

**For Businesses:**
```
Rule 2: After Hours
When: Outside business hours (6pm - 9am)
Then:
  - Send message: "Our business hours are 9am-6pm..."
  - Add label: After Hours
```

### Sales Pitch Points:
- "Save your team 2-3 hours per day with automation"
- "Never miss an urgent message with escalation rules"
- "Customers get instant acknowledgment even when team is busy"

---

## 👨‍💼 SECTION 7: Team Management

### What to Show:
**URL:** `http://localhost:3000/app/accounts/1/settings/agents`

**Features to Demonstrate:**

1. **Roles & Permissions**
   - Administrator (full access)
   - Agent (handle conversations)
   - Custom roles (limit access to specific features)

2. **Teams**
   - Create teams: Sales, Support, Billing, etc.
   - **For Clinics:** Reception, Doctors, Pharmacy, Billing
   - Assign conversations to teams
   - Team-based reporting

3. **Availability Status**
   - Online/Offline/Busy
   - Auto-offline after business hours

### Sales Pitch Points:
- "Each team member has their own login"
- "Control who sees what - protect sensitive information"
- "Track individual performance fairly"
- **For Clinics:** "HIPAA compliance - audit trail of who accessed what"

---

## 📝 SECTION 8: Canned Responses (Productivity Booster)

### What to Show:
**URL:** `http://localhost:3000/app/accounts/1/settings/canned_responses`

**Demo Examples to Create:**

**For Clinics:**
```
Shortcode: /hours
Message: "Our clinic hours are Monday-Friday 9am-5pm, Saturday 9am-1pm. 
We're closed on Sundays and public holidays."
```

```
Shortcode: /appt
Message: "I'd be happy to schedule an appointment for you. 
Could you please provide:
- Preferred date and time
- Type of consultation
- Any specific doctor preference?"
```

**For Businesses:**
```
Shortcode: /pricing
Message: "Thank you for your interest! Our pricing plans are:
- Starter: $29/month
- Professional: $79/month  
- Enterprise: Custom pricing
Which plan would you like to know more about?"
```

### Sales Pitch Points:
- "Your top agents probably type the same 10 answers all day"
- "Copy their best responses and share with whole team"
- "New hires get up to speed faster"
- "Consistent messaging across all team members"

---

## 🎨 SECTION 9: Customization (Branding)

### What to Show:
**URL:** `http://localhost:3000/app/accounts/1/settings/account`

**Customization Options:**

1. **Account Settings**
   - Company name
   - Domain
   - Support email
   - Language preferences
   - Timezone

2. **Widget Customization**
   - Brand colors (match their website)
   - Logo
   - Welcome message
   - Position (left/right)
   - Custom CSS

3. **Email Templates**
   - Customize automated emails
   - Add company branding

### Sales Pitch Points:
- "This looks like YOUR company, not a generic tool"
- "Your brand, your colors, your tone"
- "Customers don't know you're using third-party software"

---

## 🔔 SECTION 10: Customer Experience Features

### What to Show:

1. **Pre-Chat Form** (Capture Info Before Chat)
   **URL:** Inbox Settings > Widget > Pre-chat form
   - Collect name, email, phone before chat starts
   - **For Clinics:** Patient ID, Date of Birth, Insurance
   - **For Businesses:** Company name, Industry

2. **Business Hours**
   **URL:** Inbox Settings > Business Hours
   - Show different hours per channel
   - Offline message customization
   - **For Clinics:** Different hours for emergency line

3. **CSAT Surveys**
   **URL:** Inbox Settings > Configuration
   - Automatic satisfaction survey after conversation
   - "How did we do? 😊 😐 😞"
   - Collect feedback

4. **Email Notifications**
   - Customer gets email copy of conversation
   - Transcript for records

---

## 💰 SECTION 11: The Business Value Pitch

### ROI Calculator (Prepare This Before Demo)

**Time Savings:**
- Average response time before: 2 hours
- After Chatwoot: 5 minutes
- **Savings:** 1.9 hours × 50 conversations/day = 95 hours/day saved

**Cost Savings:**
- Current tools: WhatsApp Business ($X), Email system ($Y), Facebook ($Z) = Total $XYZ/month
- Chatwoot: $XX/month (your pricing)
- **Savings:** $ABC per month

**Revenue Impact:**
- Faster response = Higher conversion
- Studies show: 1-5 minute response time = 391% higher conversion vs 30+ minutes
- Better customer satisfaction = More referrals

### Pricing Discussion Points:

**What to Emphasize:**
1. "One price, unlimited channels"
2. "No per-agent pricing (unlike Intercom, Zendesk)"
3. "Self-hosted = You own your data"
4. "No surprise bills"
5. "Scale from 5 to 500 agents without price jumps"

---

## 🏥 SECTION 12: Industry-Specific Pitches

### For Medical Clinics/Hospitals:

**Use Cases to Highlight:**
1. **Appointment Scheduling**
   - Patients request appointments via any channel
   - Reception team manages from one interface
   - Automated reminders via SMS/WhatsApp

2. **Test Results Notification**
   - Secure communication for sensitive info
   - Patient can reply with questions
   - Full audit trail

3. **Prescription Refills**
   - Patients request refills
   - Pharmacy team manages queue
   - Auto-notify when ready

4. **Emergency Triage**
   - Priority labeling for urgent messages
   - Escalation rules
   - Route to on-call doctor

5. **Billing Inquiries**
   - Separate billing team inbox
   - History of previous discussions
   - Payment links in chat

**Compliance Points:**
- HIPAA-compliant setup (if configured)
- Data encryption
- Access controls
- Audit logs

### For General Businesses:

**Use Cases to Highlight:**
1. **Lead Capture**
   - Website visitors start chat
   - Sales team qualifies leads
   - Integration with CRM

2. **Customer Support**
   - Technical issues
   - Order tracking
   - Returns and refunds

3. **Sales Conversations**
   - Product questions
   - Pricing discussions
   - Demo scheduling

4. **Account Management**
   - Existing customer inquiries
   - Upsell opportunities
   - Renewal discussions

---

## 🎬 SECTION 13: The Demo Flow (30-Minute Version)

### Minute 1-5: The Hook
1. Ask about their current pain points
2. Show dashboard: "Everything in one place"
3. Quick stat: "Average business uses 7 different tools for customer communication. You only need one."

### Minute 5-15: Core Features
1. Live conversation demo (have someone message the widget)
2. Show response with canned response
3. Add private note
4. Assign to team member
5. Show contact history

### Minute 15-20: Automation Magic
1. Show one automation rule
2. Explain time savings
3. "Your team focuses on helping customers, not on repetitive tasks"

### Minute 20-25: Reports
1. Quick look at metrics
2. "This is what your boss/investors want to see"
3. ROI justification

### Minute 25-30: Closing
1. Pricing discussion
2. Implementation timeline (1-2 weeks)
3. Next steps
4. Trial offer

---

## 🛠️ SECTION 14: Technical Setup Demo (For IT Managers)

**If they have technical stakeholders present:**

### Show:
1. **Self-Hosted Option**
   - "You control the data"
   - "No vendor lock-in"
   - "Deploy on your own servers"

2. **API & Integrations**
   - RESTful API
   - Webhooks
   - Integration possibilities:
     - CRM systems
     - Appointment scheduling software
     - Payment gateways
     - Analytics tools

3. **Security Features**
   - 2-factor authentication
   - IP whitelisting
   - Role-based access control
   - Data encryption
   - Audit logs

4. **Scalability**
   - Handles thousands of conversations
   - Multi-server deployment
   - Database optimization

---

## 📋 SECTION 15: Common Objections & Responses

### Objection 1: "We're already using [WhatsApp/Email/etc.]"
**Response:** "Exactly! But your team is probably switching between 5 different apps all day. Chatwoot brings them all together. You don't stop using WhatsApp - you just manage it better."

### Objection 2: "This looks complicated"
**Response:** "Your team will learn it in 1 hour. Let me show you the agent view - it's just like sending messages on your phone. The complexity is hidden from your team."

### Objection 3: "We don't have that many conversations"
**Response:** "That's actually the perfect time to start! Set it up now while volume is low. When you grow, you're already ready. Plus, better communication = more customers = more conversations."

### Objection 4: "What about data security?"
**Response:** "Great question. [If self-hosted] You host it, you control it, you own the data. It never leaves your servers. [If cloud] We use bank-level encryption, regular backups, and you can export everything anytime."

### Objection 5: "How long does implementation take?"
**Response:** "Most businesses are up and running in 1 week. Website widget: 5 minutes. WhatsApp: 1 day. Email: 1 day. Training: 2-3 hours. You can start with just one channel today."

### Objection 6: "What if we outgrow it?"
**Response:** "Chatwoot scales from 1 agent to 1000+. Companies with millions of conversations use this. You won't outgrow it."

---

## 🎯 SECTION 16: The Perfect Demo Script

### Opening (2 min)
"Thank you for your time today. I know you're busy, so let me show you something that can save your team hours every day. Can you tell me quickly - how do your customers reach you today?"

[Listen to their answer]

"Got it. So your team is probably switching between [list their channels] all day. Let me show you how this looks in Chatwoot..."

### Dashboard (3 min)
[Open dashboard]
"This is what your manager/you sees every morning. All conversations from every channel - in one place. Right now I have [X] open conversations. I can see my team's performance, response times, everything."

### Live Demo (10 min)
"Let me show you a real conversation..."
[Open existing conversation or have someone send a test message]

"Here's a customer asking about [topic]. Watch this..."
1. Type `/` - show canned responses
2. Use canned response
3. Add private note: "Hey @teammate, can you verify this?"
4. Show contact info sidebar

"That's it. 30 seconds instead of 5 minutes of typing."

### Automation (5 min)
"Now here's where it gets really powerful..."
[Show automation rule]
"This rule automatically assigns appointment requests to your reception team. No manual sorting. No missed messages."

### Reports (3 min)
"Your manager will love this..."
[Open reports]
"See exactly how your team is performing. Who's fast, who needs help, what issues are most common."

### Pricing (5 min)
"So what does this cost? Unlike other tools that charge per agent..."
[Present pricing]
"Questions so far?"

### Closing (2 min)
"Next steps: I can set up a trial for you today. Your team can start using it tomorrow. Or we can schedule a more detailed technical demo. What works better for you?"

---

## 📊 SECTION 17: Follow-Up Materials to Send

After the demo, send:

1. **Pricing Sheet**
   - Clear breakdown
   - No hidden costs
   - Volume discounts if applicable

2. **Case Studies** (Create these)
   - Similar business that succeeded
   - Metrics: Response time reduced by X%, Customer satisfaction up by Y%

3. **Implementation Timeline**
   - Week 1: Setup
   - Week 2: Training
   - Week 3: Go Live
   - Week 4: Optimization

4. **ROI Calculator**
   - Custom to their business
   - Time savings
   - Cost savings
   - Revenue impact

5. **Technical Documentation**
   - For IT team
   - Security whitepaper
   - API documentation
   - Integration guides

---

## ✅ SECTION 18: Post-Demo Checklist

After every demo:

- [ ] Send follow-up email within 2 hours
- [ ] Include demo recording (if recorded)
- [ ] Address any questions that came up
- [ ] Provide pricing in writing
- [ ] Schedule follow-up call/meeting
- [ ] Connect them with technical team if needed
- [ ] Send case studies relevant to their industry
- [ ] Add them to CRM/follow-up system

---

## 🚀 Quick Start Demo Setup (Before Client Arrives)

**Run these steps 1 hour before demo:**

1. **Create Sample Data:**
   ```bash
   # Add 3-5 fake conversations
   # Mix of open and resolved
   # Different channels
   # Various labels
   ```

2. **Set Up Canned Responses:**
   - Create 3-5 common responses
   - Match their industry

3. **Create Automation Rule:**
   - One simple, impressive rule
   - Relevant to their business

4. **Test Website Widget:**
   - Ensure it loads fast
   - Custom colors ready
   - Test greeting message

5. **Open Tabs in Browser:**
   - Dashboard
   - Conversations
   - Reports
   - Settings > Inboxes
   - Settings > Automation

6. **Have Team Member Ready:**
   - To send test message during demo
   - Shows real-time nature

---

## 💡 Pro Tips for Successful Demos

1. **Ask Questions First**
   - "What's your biggest frustration with current system?"
   - Show features that solve THEIR problems

2. **Use Their Language**
   - If clinic: "patients" not "customers"
   - If B2B: "clients" not "users"

3. **Show, Don't Tell**
   - Live demo > Screenshots
   - Let them drive if possible

4. **Address Decision Makers**
   - Frontline staff care about: Ease of use
   - Managers care about: Reporting, productivity
   - IT cares about: Security, integration
   - Executives care about: ROI, cost

5. **Handle Multiple Stakeholders**
   - If multiple people in demo, address each person's concerns
   - "For your team [agents], this means..."
   - "For you [manager], this means..."

6. **Create Urgency (Ethically)**
   - "Teams using omnichannel support grow 25% faster"
   - "Every day you wait, you're losing conversations to competitors"

7. **Social Proof**
   - "Similar businesses in [their industry] are using this"
   - "Our fastest growing segment is [their type]"

---

## 🎓 Training Your Own Sales Team

If you're building a sales team to sell Chatwoot:

### Training Program (1 Week):

**Day 1-2: Product Knowledge**
- Go through every feature
- Practice with test account
- Role-play conversations

**Day 3: Industry Research**
- Learn different industry pain points
- Customize pitch for each vertical

**Day 4: Demo Practice**
- Record yourself doing demo
- Watch and critique
- Practice until smooth (30 min demo)

**Day 5: Objection Handling**
- Role-play common objections
- Practice responses
- Build confidence

**Ongoing:**
- Weekly demo reviews
- Share successful pitches
- Update demo based on feedback

---

## 📈 Success Metrics to Track

**Track These for Each Demo:**
1. Demo completion rate (did they stay full time?)
2. Questions asked (more = more interest)
3. Technical questions (indicates serious consideration)
4. Next step agreement rate
5. Time to close after demo
6. Conversion rate

**Optimize Based On:**
- Which features got best reaction
- Where people zoned out
- What objections came up most
- Which industries convert best

---

## 🎬 Ready to Demo!

**Your First Demo Checklist:**

- [ ] Login credentials work (admin@zubio.com / Admin123!)
- [ ] Sample conversations created
- [ ] Canned responses set up
- [ ] Website widget working
- [ ] Reports showing data
- [ ] Automation rule created
- [ ] Browser tabs open and ready
- [ ] Internet connection stable
- [ ] Screen sharing working (if virtual)
- [ ] Practiced demo once today
- [ ] Client research done
- [ ] Pricing sheet ready
- [ ] Follow-up email drafted
- [ ] Calendar ready for next meeting

**During Demo:**
- [ ] Smile and be enthusiastic
- [ ] Ask questions
- [ ] Listen more than talk
- [ ] Show relevant features only
- [ ] Handle objections confidently
- [ ] Ask for the sale
- [ ] Schedule next step

**Good luck with your demos! 🚀**

---

## 🔗 Additional Resources

**For More Information:**
- Technical Documentation: Check `docs/` folder
- API Reference: http://localhost:3000/api-docs (if enabled)
- Community Forum: Chatwoot community
- Video Tutorials: Record your own or use official ones

**Next Steps:**
1. Practice this demo flow 5-10 times
2. Record yourself and critique
3. Customize for your target market
4. Start booking demos!

---

**Remember:** You're not selling software. You're selling:
- Time savings for their team
- Better customer experience
- Business growth
- Peace of mind
- Professional image

The software is just the tool that delivers these benefits.

**Now go close some deals! 💼**
