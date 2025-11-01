#!/bin/bash

# Zubio Development Setup Script
# This script helps new contributors get started quickly

set -e

echo "🚀 Welcome to Zubio Development Setup!"
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first:"
    echo "   https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first:"
    echo "   https://docs.docker.com/compose/install/"
    exit 1
fi

echo "✅ Docker and Docker Compose are installed"
echo ""

# Check if .env exists
if [ ! -f .env ]; then
    echo "📝 Creating .env file from .env.brand.example..."
    cp .env.brand.example .env
    echo "✅ .env file created"
    echo ""
    echo "⚠️  Please review and update .env with your configuration"
    echo "   Especially update SECRET_KEY_BASE and any other secrets"
    echo ""
else
    echo "✅ .env file already exists"
    echo ""
fi

# Stop any existing PostgreSQL service
echo "🛑 Checking for conflicting PostgreSQL service..."
if systemctl is-active --quiet postgresql 2>/dev/null; then
    echo "   Found active PostgreSQL service, stopping it..."
    sudo systemctl stop postgresql || echo "   Could not stop PostgreSQL service (may need manual intervention)"
else
    echo "   No conflicting PostgreSQL service found"
fi
echo ""

# Start Docker Compose services
echo "🐳 Starting Docker Compose services..."
docker-compose down 2>/dev/null || true
docker-compose up -d

echo "⏳ Waiting for services to start (30 seconds)..."
sleep 30

# Check if Rails is responding
echo "🔍 Checking if Rails is responding..."
if curl -s -o /dev/null -w "%{http_code}" http://localhost:3000 | grep -q "200\|302"; then
    echo "✅ Rails is responding"
else
    echo "⚠️  Rails may not be fully ready yet, checking logs..."
    docker-compose logs --tail=20 rails
fi
echo ""

# Run migrations
echo "📊 Running database migrations..."
docker-compose exec -T rails bundle exec rails db:migrate
echo "✅ Migrations completed"
echo ""

# Check if admin user exists
echo "👤 Checking for admin user..."
ADMIN_EXISTS=$(docker-compose exec -T rails bundle exec rails runner "puts User.find_by(email: 'dev@zubio.com').present?" 2>/dev/null | tail -1)

if [ "$ADMIN_EXISTS" = "false" ]; then
    echo "   Creating development admin user..."
    docker-compose exec -T rails bundle exec rails runner "
    account = Account.create!(name: 'Development Account')
    user = User.create!(
      email: 'dev@zubio.com',
      password: 'Password123!',
      password_confirmation: 'Password123!',
      name: 'Developer',
      confirmed_at: Time.now
    )
    AccountUser.create!(account: account, user: user, role: :administrator)
    " 2>/dev/null
    echo "✅ Admin user created"
else
    echo "✅ Admin user already exists"
fi
echo ""

# Show status
echo "📊 Service Status:"
docker-compose ps
echo ""

echo "🎉 Setup Complete!"
echo ""
echo "📌 Important Information:"
echo "   🌐 Application:  http://localhost:3000"
echo "   📧 MailHog:      http://localhost:8025"
echo "   👤 Login Email:  dev@zubio.com"
echo "   🔑 Password:     Password123!"
echo ""
echo "📚 Next Steps:"
echo "   1. Visit http://localhost:3000/app/login to access the app"
echo "   2. Read CONTRIBUTING.md for development guidelines"
echo "   3. Check out the docs/ folder for technical documentation"
echo ""
echo "🛠️  Useful Commands:"
echo "   docker-compose logs -f rails    # View Rails logs"
echo "   docker-compose logs -f sidekiq  # View Sidekiq logs"
echo "   docker-compose down             # Stop all services"
echo "   docker-compose restart rails    # Restart Rails"
echo ""
echo "Happy coding! 🚀"
