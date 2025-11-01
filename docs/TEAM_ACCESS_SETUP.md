# Team Access Setup Guide

## 🎯 Recommended Approach: Collaborative Repository

For a private team project, give your team direct access to your repository rather than using forks.

## Step 1: Add Team Members to Repository

### On GitHub:

1. **Go to your repository:** `https://github.com/didier-building/zubio-chatwoot`

2. **Navigate to Settings → Collaborators and teams**
   - Click "Add people" or "Add teams"

3. **Add team members with appropriate roles:**
   - **Admin** - Full access (project leads)
   - **Write** - Can push branches and create PRs (developers)
   - **Read** - View only (QA, designers)

### Recommended: Create a GitHub Team

1. Go to your organization: `https://github.com/didier-building`
2. Click "Teams" → "New team"
3. Create team: "Zubio Developers"
4. Add members to the team
5. Give the team "Write" access to the repository

## Step 2: Configure Branch Protection

### Protect the `develop` branch:

1. Go to **Settings → Branches → Branch protection rules**
2. Click "Add rule"
3. Configure for `develop`:

```yaml
Branch name pattern: develop

☑️ Require pull request reviews before merging
   Number of required approvals: 1 (or 2 for stricter review)
   
☑️ Dismiss stale pull request approvals when new commits are pushed

☑️ Require status checks to pass before merging
   (Add CI checks when ready: tests, linting, etc.)
   
☑️ Require branches to be up to date before merging

☑️ Include administrators
   (Even admins must follow the rules)

☑️ Restrict who can push to matching branches
   (Optional: only allow specific people to merge)
```

4. Click "Create" or "Save changes"

### Protect the `main` branch (if you use it for production):

Repeat the same steps but with stricter rules:
- Require 2+ approvals
- Only specific people can merge to main
- Require all status checks

## Step 3: Team Member Workflow

Once added to the repository, team members should:

### Initial Setup
```bash
# 1. Clone the main repository (not a fork)
git clone git@github.com:didier-building/zubio-chatwoot.git
cd zubio-chatwoot

# 2. Run setup
./setup-dev.sh

# 3. Verify they can access
git remote -v
# Should show: origin  git@github.com:didier-building/zubio-chatwoot.git
```

### Daily Workflow
```bash
# 1. Update develop branch
git checkout develop
git pull origin develop

# 2. Create feature branch
git checkout -b feature/my-feature

# 3. Make changes and commit
git add .
git commit -m "feat: add new feature"

# 4. Push to origin (the main repository)
git push origin feature/my-feature

# 5. Create Pull Request on GitHub
# Target: develop ← feature/my-feature

# 6. After PR is approved and merged
git checkout develop
git pull origin develop
git branch -d feature/my-feature
```

## Step 4: Team Communication

### Set up communication channels:

1. **Create GitHub Projects board** (optional)
   - Repository → Projects → New project
   - Use for task management

2. **Enable GitHub Discussions** (optional)
   - Settings → Features → Discussions
   - Use for team conversations

3. **External communication:**
   - Slack/Discord for daily chat
   - GitHub Issues for bug reports and features
   - GitHub PRs for code review discussions

## Step 5: Configure Repository Settings

### General Settings

1. **Settings → General**
   ```
   ☑️ Automatically delete head branches
      (Cleans up merged feature branches)
   
   ☑️ Allow merge commits
   ☑️ Allow squash merging
   ☐ Allow rebase merging (optional)
   ```

2. **Default branch:** Set to `develop`

### Labels

Create these labels for better organization:

```
Priority:
- priority: critical (red)
- priority: high (orange)
- priority: medium (yellow)
- priority: low (blue)

Type:
- bug (red)
- enhancement (green)
- documentation (blue)
- refactor (yellow)
- test (purple)

Status:
- good first issue (green)
- help wanted (yellow)
- wip (orange)
- blocked (red)
- ready for review (green)
```

## Step 6: CI/CD Setup (Optional but Recommended)

### GitHub Actions

Create `.github/workflows/ci.yml`:

```yaml
name: CI

on:
  pull_request:
    branches: [develop, main]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run RuboCop
        run: bundle exec rubocop
      - name: Run ESLint
        run: pnpm eslint

  test:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:14
        env:
          POSTGRES_PASSWORD: postgres
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
    steps:
      - uses: actions/checkout@v3
      - name: Run tests
        run: bundle exec rspec
```

## Alternative: If You Want to Keep Fork Workflow

If team members prefer to fork (for learning or open-source contribution):

### Team Member Setup:
```bash
# 1. Fork the repository on GitHub
# Click "Fork" button on github.com/didier-building/zubio-chatwoot

# 2. Clone their fork
git clone git@github.com:THEIR_USERNAME/zubio-chatwoot.git
cd zubio-chatwoot

# 3. Add upstream remote
git remote add upstream git@github.com:didier-building/zubio-chatwoot.git

# 4. Before starting work, sync with upstream
git fetch upstream
git checkout develop
git merge upstream/develop
git push origin develop

# 5. Create feature branch and work
git checkout -b feature/my-feature
# ... make changes ...
git push origin feature/my-feature

# 6. Create PR from their fork to your repository
# On GitHub: their fork → Create Pull Request → target: didier-building/zubio-chatwoot
```

## 📊 Comparison Table

| Aspect | Collaborative Repo | Fork Workflow |
|--------|-------------------|---------------|
| **Setup complexity** | Simple | Moderate |
| **Team workflow** | Fast | Slower |
| **Code review** | Easy | Easy |
| **Access control** | GitHub permissions | Public/fork access |
| **Best for** | Private teams | Open source |
| **Upstream sync** | Not needed | Required |
| **Our recommendation** | ✅ **YES** | Only if open source |

## 🎯 Summary

**For your private team project:**
1. ✅ Use collaborative repository (give team direct access)
2. ✅ Set up branch protection on `develop`
3. ✅ Team members clone main repo directly
4. ✅ Work on feature branches
5. ✅ Submit PRs to `develop`
6. ✅ Review and merge

**This is the standard industry practice for private team projects.**

## 📞 Next Actions for You

1. [ ] Add team members to repository with "Write" access
2. [ ] Set up branch protection on `develop` branch
3. [ ] Share this guide with your team
4. [ ] Ensure team members can clone and run `./setup-dev.sh`
5. [ ] Have each team member create a test PR to verify workflow

---

**Questions?** Feel free to ask!
