# Contributing to Zubio

Welcome to the Zubio project! This guide will help you get started with contributing.

## 🚀 Quick Start

### Prerequisites

- Docker and Docker Compose
- Git
- Node.js 18+ and pnpm (for local frontend development)
- Ruby 3.4+ (for local backend development)

### Initial Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/didier-building/zubio.git
   cd zubio
   ```

2. **Copy environment configuration:**
   ```bash
   cp .env.example .env
   # Or use the branded version:
   cp .env.brand.example .env
   ```

3. **Start the application:**
   ```bash
   docker-compose up -d
   ```

4. **Run database migrations:**
   ```bash
   docker-compose exec rails bundle exec rails db:migrate
   ```

5. **Create a super admin account:**
   ```bash
   docker-compose exec rails bundle exec rails runner "
   account = Account.create!(name: 'Development Account')
   user = User.create!(
     email: 'dev@zubio.com',
     password: 'Password123!',
     password_confirmation: 'Password123!',
     name: 'Developer',
     confirmed_at: Time.now
   )
   AccountUser.create!(account: account, user: user, role: :administrator)
   puts 'Login at http://localhost:3000/app/login with dev@zubio.com / Password123!'
   "
   ```

6. **Access the application:**
   - App: http://localhost:3000
   - MailHog (test emails): http://localhost:8025

## 📋 Development Workflow

### Branch Strategy

- `develop` - Main development branch (default)
- `main` - Production-ready code
- Feature branches: `feature/your-feature-name`
- Bug fixes: `fix/bug-description`
- Hotfixes: `hotfix/issue-description`

### Making Changes

1. **Create a feature branch:**
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b feature/my-new-feature
   ```

2. **Make your changes following our guidelines** (see Development Guidelines below)

3. **Test your changes:**
   ```bash
   # Ruby tests
   docker-compose exec rails bundle exec rspec
   
   # JavaScript/Vue tests
   pnpm test
   
   # Linting
   pnpm eslint
   bundle exec rubocop
   ```

4. **Commit your changes:**
   ```bash
   git add .
   git commit -m "feat: add new feature description"
   ```

5. **Push and create a pull request:**
   ```bash
   git push origin feature/my-new-feature
   ```
   Then open a PR on GitHub targeting the `develop` branch.

## 🎯 Development Guidelines

### Code Style

#### Ruby
- Follow RuboCop rules (max 150 char line length)
- Use compact module/class definitions
- Add proper validations and indexes to models
- Write clear, descriptive names

#### JavaScript/Vue
- Use ESLint (Airbnb base + Vue 3 recommended)
- Always use Composition API with `<script setup>`
- Use PascalCase for Vue components
- Use camelCase for events
- Use i18n for all user-facing strings (no bare strings in templates)

#### Styling
- **Use Tailwind CSS only** - no custom CSS, no scoped styles, no inline styles
- Refer to `tailwind.config.js` for color definitions

### Testing

- Write tests for new features
- Update existing tests when modifying functionality
- Run tests before pushing

### Translations

- **Only update `en.yml` and `en.json`**
- Other languages are managed by the community
- Backend i18n → `config/locales/en.yml`
- Frontend i18n → `app/javascript/dashboard/i18n/locale/en/*.json`

### Commits

Follow conventional commits:
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting)
- `refactor:` - Code refactoring
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks

## 🛠️ Common Tasks

### Running the Development Server

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f rails

# Stop services
docker-compose down
```

### Database Tasks

```bash
# Run migrations
docker-compose exec rails bundle exec rails db:migrate

# Rollback migration
docker-compose exec rails bundle exec rails db:rollback

# Open Rails console
docker-compose exec rails bundle exec rails console
```

### Frontend Development

```bash
# Install dependencies
pnpm install

# Run linting
pnpm eslint
pnpm eslint:fix

# Run tests
pnpm test
```

### Backend Development

```bash
# Install dependencies
bundle install

# Run linting
bundle exec rubocop
bundle exec rubocop -a  # auto-fix

# Run specific test
bundle exec rspec spec/models/user_spec.rb
```

## 📝 Pull Request Guidelines

### Before Submitting

- [ ] Code follows style guidelines
- [ ] Tests pass locally
- [ ] New tests added for new features
- [ ] Documentation updated if needed
- [ ] No merge conflicts with `develop`
- [ ] Commit messages follow convention

### PR Description Template

```markdown
## Description
Brief description of what this PR does

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
How has this been tested?

## Checklist
- [ ] Tests pass
- [ ] Linting passes
- [ ] Documentation updated
```

## 📖 Additional Resources

- [Architecture Documentation](docs/architecture.md)
- [Development Guidelines](AGENTS.md)

## 🎉 Thank You!

Your contributions make Zubio better for everyone!
