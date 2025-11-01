# Team Member Onboarding Checklist

Welcome to the Zubio team! 🎉

Follow this checklist to get fully set up and ready to contribute.

## 🔐 Access & Accounts

- [ ] GitHub repository access granted
- [ ] Added to team communication channel (Slack/Discord)
- [ ] Development environment credentials shared
- [ ] Code review permissions configured
- [ ] CI/CD pipeline access (if needed)

## 💻 Local Development Setup

- [ ] Docker and Docker Compose installed
- [ ] Repository cloned locally
- [ ] Environment variables configured (`.env` file)
- [ ] Development setup script run (`./setup-dev.sh`)
- [ ] Application running successfully at http://localhost:3000
- [ ] Can log in with test credentials
- [ ] MailHog accessible at http://localhost:8025

## 📚 Documentation Review

- [ ] Read [README.md](../README.md)
- [ ] Read [CONTRIBUTING.md](../CONTRIBUTING.md)
- [ ] Read [AGENTS.md](../AGENTS.md) - Development guidelines
- [ ] Reviewed architecture documentation in [docs/](../docs/)
- [ ] Familiar with project structure
- [ ] Understand branching strategy (git-flow)

## 🛠️ Development Tools

- [ ] IDE/Editor configured (VS Code recommended)
- [ ] ESLint extension installed
- [ ] RuboCop extension installed (for Ruby)
- [ ] Git configured with correct user name/email
- [ ] SSH keys set up for GitHub
- [ ] Docker Desktop running smoothly

## 🧪 Testing & Quality

- [ ] Successfully run backend tests (`bundle exec rspec`)
- [ ] Successfully run frontend tests (`pnpm test`)
- [ ] Run linting tools (ESLint, RuboCop)
- [ ] Understand test writing conventions
- [ ] Know how to run specific test files

## 🔄 Git Workflow

- [ ] Understand feature branch workflow
- [ ] Know how to create a feature branch
- [ ] Familiar with commit message conventions
- [ ] Can create and submit a pull request
- [ ] Understand code review process
- [ ] Know how to resolve merge conflicts

## 📖 Product Knowledge

- [ ] Understand Zubio's purpose and features
- [ ] Familiar with the admin dashboard
- [ ] Know how the chat widget works
- [ ] Understand conversation management
- [ ] Aware of AI features (Zubio AI)
- [ ] Familiar with help center portal

## 🎯 First Tasks

### Day 1-2
- [ ] Complete all setup steps
- [ ] Explore the codebase
- [ ] Run the application and test features
- [ ] Review open issues and PRs

### Week 1
- [ ] Pick a "good first issue" to work on
- [ ] Make your first contribution (documentation, small fix)
- [ ] Get your first PR reviewed and merged
- [ ] Attend team standup/meetings

### Week 2-4
- [ ] Work on a small feature
- [ ] Review other team members' PRs
- [ ] Fix a bug from the backlog
- [ ] Contribute to documentation improvements

## 🤝 Team Integration

- [ ] Introduced to team members
- [ ] Attended team meeting/standup
- [ ] Know who to ask for help on different topics:
  - Backend (Rails): _______
  - Frontend (Vue): _______
  - DevOps/Docker: _______
  - Design/UI: _______
- [ ] Joined code review rotation
- [ ] Have a mentor/buddy assigned (if applicable)

## 📝 Resources

### Quick Links
- Repository: https://github.com/didier-building/zubio
- Local App: http://localhost:3000
- MailHog: http://localhost:8025

### Documentation
- [Contributing Guide](../CONTRIBUTING.md)
- [Development Guidelines](../AGENTS.md)
- [Architecture Docs](../docs/architecture.md)
- [Database Design](../docs/database_design.md)

### Useful Commands
```bash
# Start services
docker-compose up -d

# View logs
docker-compose logs -f rails

# Run tests
bundle exec rspec
pnpm test

# Lint code
bundle exec rubocop
pnpm eslint

# Rails console
docker-compose exec rails bundle exec rails console

# Stop services
docker-compose down
```

## ✅ Ready to Contribute!

Once you've completed this checklist, you're ready to start contributing!

**Your first contribution:**
1. Look for issues labeled `good first issue`
2. Comment on the issue to claim it
3. Create a feature branch
4. Make your changes
5. Submit a pull request

**Questions?** Don't hesitate to ask the team!

---

**Completed by:** _________________  
**Date:** _________________  
**Verified by:** _________________
