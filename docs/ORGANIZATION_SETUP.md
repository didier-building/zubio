# Organization Repository Setup for Zubio

## Your Situation

You've forked Chatwoot (open-source) and are creating your own branded, private version (Zubio) for your personal/organization use.

## ✅ Current Setup is CORRECT

Your current repository structure is already ideal:
- Owner: `didier-building`
- Repository: `didier-building/zubio-chatwoot`
- Status: Private (recommended)
- Type: Personal/Organization repository
- Branch: `develop`

**This is the right approach!** Don't create a new repository.

## 🔒 Make Repository Private (If Not Already)

1. Go to repository Settings
2. Scroll to "Danger Zone"
3. Click "Change visibility"
4. Select "Private"
5. Confirm

This ensures:
- Only your organization members can see it
- Your unique features stay proprietary
- Your branding is protected

## 👥 Team Collaboration in Organization Repository

### Step 1: Create Organization Teams

Go to: `https://github.com/didier-building` → Teams

Create teams based on roles:

```
📁 Organization: didier-building
  ├── 👥 Team: zubio-developers
  │   ├── Role: Write (can push and create PRs)
  │   └── Members: All developers
  │
  ├── 👥 Team: zubio-maintainers
  │   ├── Role: Maintain (can manage without admin access)
  │   └── Members: Senior developers
  │
  └── 👥 Team: zubio-admins
      ├── Role: Admin (full access)
      └── Members: Project leads
```

### Step 2: Add Teams to Repository

1. Go to repository: `Settings → Collaborators and teams`
2. Click "Add teams"
3. Select your teams:
   - **zubio-developers** → Write access
   - **zubio-maintainers** → Maintain access  
   - **zubio-admins** → Admin access

### Step 3: Team Members Clone & Work

Team members work directly with the organization repository:

```bash
# Team members clone the organization repo
git clone git@github.com:didier-building/zubio-chatwoot.git
cd zubio-chatwoot

# Run setup
./setup-dev.sh

# Work on features
git checkout develop
git pull origin develop
git checkout -b feature/new-zubio-feature
# ... make changes ...
git push origin feature/new-zubio-feature
# Create PR to develop branch
```

**No forking needed** - team members work directly in the organization repository.

## 📋 Branch Strategy for Private Organization Projects

```
main (production)
  ↑
develop (development)
  ↑
feature/zubio-custom-feature-1
feature/zubio-custom-feature-2
fix/bug-fix-1
```

### Branch Protection Rules

**For `develop` branch:**
```yaml
Settings → Branches → Add rule

Branch name pattern: develop

☑️ Require pull request reviews before merging
   Require approvals: 1 reviewer
   
☑️ Dismiss stale pull request approvals when new commits are pushed

☑️ Require status checks to pass before merging
   (Add when you have CI/CD)

☑️ Require conversation resolution before merging

☑️ Include administrators
```

**For `main` branch (production):**
```yaml
Branch name pattern: main

☑️ Require pull request reviews before merging
   Require approvals: 2 reviewers
   
☑️ Require status checks to pass before merging

☑️ Restrict who can push to matching branches
   Only: zubio-maintainers and zubio-admins

☑️ Include administrators
```

## 🔄 Staying Updated with Upstream Chatwoot (Optional)

Since you forked from Chatwoot, you might want to pull upstream updates occasionally:

### One-Time Setup
```bash
# Add Chatwoot as upstream remote
git remote add upstream https://github.com/chatwoot/chatwoot.git
git fetch upstream
```

### Pulling Updates (When You Want Them)
```bash
# Create an upstream sync branch
git checkout develop
git pull origin develop
git checkout -b sync/chatwoot-upstream

# Merge upstream changes
git fetch upstream
git merge upstream/master

# Resolve conflicts (especially in your branded files)
# Test thoroughly!

# Push and create PR
git push origin sync/chatwoot-upstream
# Create PR: sync/chatwoot-upstream → develop
```

**Important:** 
- Only pull upstream when YOU want to
- Your custom features and branding take priority
- Test everything after merging upstream changes
- You're not obligated to stay in sync

## 🎨 Your Custom Development Strategy

Since this is now YOUR product (Zubio), you can:

### 1. Custom Features (Add freely)
```bash
feature/zubio-ai-assistant
feature/zubio-analytics-dashboard  
feature/zubio-custom-integrations
```

### 2. Brand Customization (Already done ✅)
- Colors, logos, naming (Zubio)
- Custom UI/UX
- Your own documentation
- Your own marketing site

### 3. Remove Unwanted Features
```bash
remove/feature-you-dont-need
```

### 4. Your Own Roadmap
- Not bound by Chatwoot's roadmap
- Develop features for YOUR customers
- Your own release schedule

## 📝 License Considerations

Since Chatwoot is MIT licensed:

✅ **You CAN:**
- Use commercially
- Modify freely  
- Distribute (even as closed source)
- Use for private internal tools
- Rebrand completely

✅ **You MUST:**
- Include the original MIT license somewhere
- Keep copyright notices for Chatwoot code

### Implementation

Create a `THIRD_PARTY_NOTICES.md`:
```markdown
# Third Party Notices

Zubio is built on top of Chatwoot, which is licensed under MIT.

## Chatwoot

Copyright (c) 2019-2024 Chatwoot

MIT License - See below for full license text
[Include MIT license text]
```

**Where to keep it:**
- `THIRD_PARTY_NOTICES.md` in repository
- Not required in UI
- Required in source code distribution

## 🚀 Recommended Workflow for Your Team

### New Feature Development

```bash
# 1. Developer picks a task
# 2. Creates branch from develop
git checkout develop
git pull origin develop
git checkout -b feature/zubio-new-dashboard

# 3. Develops feature
# 4. Tests locally
./setup-dev.sh  # if needed
bundle exec rspec
pnpm test

# 5. Push to organization repo
git push origin feature/zubio-new-dashboard

# 6. Create PR on GitHub
# Title: "feat: Add new Zubio dashboard"
# Target: develop

# 7. Team reviews
# 8. Merge when approved
# 9. Delete feature branch (automatic if configured)
```

### Release Process

```bash
# When ready to release
git checkout develop
git pull origin develop
git checkout main
git merge develop
git tag -a v1.0.0 -m "Zubio v1.0.0 - Initial branded release"
git push origin main --tags
```

## 📊 Repository Structure

```
didier-building/
├── zubio-chatwoot (THIS REPO - Main product)
│   ├── Private
│   ├── Teams: zubio-developers, zubio-maintainers, zubio-admins
│   └── Branches: main, develop, feature/*
│
├── zubio-docs (Optional - Separate docs)
│   └── Private/Public documentation
│
├── zubio-infrastructure (Optional - DevOps)
│   └── Deployment configs, K8s, etc.
│
└── zubio-mobile (Optional - Mobile apps)
    └── iOS/Android apps
```

## 🎯 Team Access Summary

### How Your Team Contributes

1. **No Forking** - Team works directly in organization repo
2. **Team-based access** - Use GitHub teams for permissions
3. **Branch workflow** - feature → develop → main
4. **Pull requests** - All changes via PR with review
5. **Private repository** - Keep your competitive advantages secret

### What Team Members Do

```bash
# They clone the organization repository
git clone git@github.com:didier-building/zubio-chatwoot.git

# They DO NOT fork to their personal accounts
# They work directly with the organization repo
```

## ✅ Action Items for You

1. **Repository Settings**
   - [ ] Ensure repository is Private
   - [ ] Set default branch to `develop`
   - [ ] Enable "Automatically delete head branches"

2. **Team Setup**
   - [ ] Create GitHub teams (zubio-developers, zubio-maintainers, zubio-admins)
   - [ ] Add team members to appropriate teams
   - [ ] Give teams access to repository

3. **Branch Protection**
   - [ ] Protect `develop` (require 1 review)
   - [ ] Protect `main` (require 2 reviews)

4. **Documentation**
   - [ ] Add `THIRD_PARTY_NOTICES.md` with Chatwoot attribution
   - [ ] Update README with Zubio branding (already done ✅)
   - [ ] Share team docs with your developers

5. **Communication**
   - [ ] Set up team Slack/Discord
   - [ ] Share repository access with team
   - [ ] Schedule kickoff meeting

## 🎉 You're All Set!

Your current setup is already correct:
- ✅ Organization repository (didier-building/zubio-chatwoot)
- ✅ Rebranded to Zubio
- ✅ Ready for team collaboration
- ✅ Can add custom features
- ✅ Private to your organization

**No need to create a new repository. Just add your team and start building!**

---

**Next:** Add your team members and point them to `/CONTRIBUTING.md` to get started!
