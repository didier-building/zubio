# Zubio Development Quick Reference

## 🚀 Common Commands

### Docker Services
```bash
# Start all services
docker-compose up -d

# Stop all services
docker-compose down

# View service status
docker-compose ps

# Restart a specific service
docker-compose restart rails
docker-compose restart sidekiq

# View logs
docker-compose logs -f rails
docker-compose logs -f sidekiq
docker-compose logs -f postgres

# Rebuild containers
docker-compose build
docker-compose up -d --build
```

### Database
```bash
# Run migrations
docker-compose exec rails bundle exec rails db:migrate

# Rollback last migration
docker-compose exec rails bundle exec rails db:rollback

# Reset database (⚠️ destroys all data)
docker-compose exec rails bundle exec rails db:reset

# Open database console
docker-compose exec postgres psql -U postgres -d chatwoot

# Rails console
docker-compose exec rails bundle exec rails console

# Run seeds
docker-compose exec rails bundle exec rails db:seed
```

### Backend (Ruby/Rails)
```bash
# Install dependencies
bundle install

# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/user_spec.rb

# Run specific test (by line number)
bundle exec rspec spec/models/user_spec.rb:42

# Run linting
bundle exec rubocop

# Auto-fix linting issues
bundle exec rubocop -a

# Rails console
docker-compose exec rails bundle exec rails console

# Run a Rails script
docker-compose exec rails bundle exec rails runner "puts User.count"
```

### Frontend (Vue.js/JavaScript)
```bash
# Install dependencies
pnpm install

# Run tests
pnpm test

# Run tests in watch mode
pnpm test:watch

# Run linting
pnpm eslint

# Auto-fix linting issues
pnpm eslint:fix

# Build for production
pnpm build

# Dev server (Vite)
# Already running in docker-compose on port 3036
```

### Git Workflow
```bash
# Switch to develop and update
git checkout develop
git pull origin develop

# Create feature branch
git checkout -b feature/my-feature

# Add and commit changes
git add .
git commit -m "feat: add new feature"

# Push to remote
git push origin feature/my-feature

# Update branch with latest develop
git checkout develop
git pull
git checkout feature/my-feature
git merge develop

# Or rebase
git rebase develop
```

## 📁 Important File Locations

### Backend
- Models: `app/models/`
- Controllers: `app/controllers/`
- Services: `app/services/`
- Background Jobs: `app/jobs/`
- Mailers: `app/mailers/`
- Views (Liquid): `app/views/`
- Migrations: `db/migrate/`
- Routes: `config/routes.rb`
- Initializers: `config/initializers/`

### Frontend
- Vue Components: `app/javascript/dashboard/components/`
- Routes: `app/javascript/dashboard/routes/`
- Store (Vuex): `app/javascript/dashboard/store/`
- i18n: `app/javascript/dashboard/i18n/locale/en/`
- Styles: `app/javascript/dashboard/assets/scss/`
- Widget: `app/javascript/widget/`

### Configuration
- Environment: `.env`
- Docker: `docker-compose.yml`
- Rails: `config/application.rb`
- Database: `config/database.yml`
- Tailwind: `tailwind.config.js`
- Vite: `vite.config.ts`

### Tests
- Backend: `spec/`
- Frontend: `app/javascript/**/*.spec.js`

## 🎨 Code Style

### Ruby
```ruby
# Use compact module/class definitions
class Users::ProfileController < ApplicationController
end

# Not nested
module Users
  class ProfileController < ApplicationController
  end
end

# Use strong params
def user_params
  params.require(:user).permit(:name, :email)
end
```

### Vue.js
```vue
<!-- Always use Composition API with script setup -->
<script setup>
import { ref, computed } from 'vue';

const count = ref(0);
const doubleCount = computed(() => count.value * 2);
</script>

<template>
  <!-- Use i18n, no bare strings -->
  <div class="flex items-center">
    <h1>{{ $t('DASHBOARD.TITLE') }}</h1>
  </div>
</template>

<!-- No scoped styles - use Tailwind only -->
```

### Styling (Tailwind only)
```vue
<!-- ✅ Good -->
<div class="flex items-center justify-between p-4 bg-white rounded-lg shadow">
  <span class="text-lg font-semibold text-gray-900">Title</span>
</div>

<!-- ❌ Bad - don't use custom CSS -->
<div class="custom-container">
  <span class="my-title">Title</span>
</div>

<style>
.custom-container { /* Don't do this */ }
</style>
```

## 🐛 Debugging Tips

### Rails Console Shortcuts
```ruby
# Find records
User.find(1)
User.find_by(email: 'admin@zubio.com')
User.where(role: :administrator)

# Create records
User.create!(name: 'Test', email: 'test@example.com')

# Update records
user = User.first
user.update!(name: 'New Name')

# Delete records
User.find(1).destroy

# Reload configuration
Rails.application.reload_routes!
InstallationConfig.clear_cache

# Check routes
Rails.application.routes.routes.map { |r| "#{r.verb} #{r.path.spec}" }
```

### Common Issues

**Redis connection error:**
```bash
# Check if Redis is running
docker-compose ps redis
# Restart Redis
docker-compose restart redis
```

**Port already in use:**
```bash
# Find process using port 3000
sudo lsof -i :3000
# Kill the process
kill -9 <PID>
```

**Database doesn't exist:**
```bash
docker-compose exec rails bundle exec rails db:create db:migrate
```

**Chatwoot branding still showing:**
```bash
# Update database configs
docker-compose exec rails bundle exec rails runner "
InstallationConfig.find_or_create_by(name: 'BRAND_NAME').tap { |c| c.value = 'Zubio'; c.save! }
InstallationConfig.find_or_create_by(name: 'INSTALLATION_NAME').tap { |c| c.value = 'Zubio'; c.save! }
"
# Restart Rails
docker-compose restart rails
```

## 🧪 Testing

### Running Tests
```bash
# All backend tests
bundle exec rspec

# Specific file
bundle exec rspec spec/models/user_spec.rb

# Specific test
bundle exec rspec spec/models/user_spec.rb:42

# With coverage
COVERAGE=true bundle exec rspec

# All frontend tests
pnpm test

# Watch mode
pnpm test:watch
```

### Writing Tests
```ruby
# RSpec example
RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
  end

  describe '#display_name' do
    it 'returns the user name' do
      user = create(:user, name: 'John')
      expect(user.display_name).to eq('John')
    end
  end
end
```

## 🔧 Troubleshooting

### Services not starting
1. Check Docker is running
2. Check for port conflicts
3. View logs: `docker-compose logs`
4. Try rebuilding: `docker-compose build`

### Database migration issues
1. Check current schema: `docker-compose exec rails bundle exec rails db:version`
2. Check pending migrations: `docker-compose exec rails bundle exec rails db:migrate:status`
3. Rollback if needed: `docker-compose exec rails bundle exec rails db:rollback`

### Frontend not reloading
1. Check Vite logs: `docker-compose logs -f vite`
2. Restart Vite: `docker-compose restart vite`
3. Clear browser cache

## 📚 Resources

- [Full Contributing Guide](../CONTRIBUTING.md)
- [Team Onboarding](TEAM_ONBOARDING.md)
- [Architecture Docs](architecture.md)
- [Rails API Docs](https://api.rubyonrails.org/)
- [Vue.js Docs](https://vuejs.org/)
- [Tailwind CSS Docs](https://tailwindcss.com/)
