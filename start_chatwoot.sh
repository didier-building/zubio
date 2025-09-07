#!/bin/bash

echo "🚀 Starting Chatwoot Application..."
echo "=================================="

# Check if Docker image exists
if ! docker images | grep -q "chatwoot.*development"; then
    echo "❌ Chatwoot Docker image not found. Please run the build first:"
    echo "   docker build -t chatwoot:development -f ./docker/Dockerfile ."
    exit 1
fi

echo "✅ Docker image found"

# Start the services
echo "🔧 Starting services..."

# Start mailhog first for email testing
echo "📧 Starting mailhog (email testing)..."
docker-compose up -d mailhog

# Setup database if needed
echo "🗄️  Setting up database..."
docker run --rm --network host --env-file .env chatwoot:development bundle exec rails db:prepare

# Start the main application services
echo "🎯 Starting Chatwoot application..."
docker-compose up -d vite sidekiq

# Start the main Rails server
echo "🌐 Starting Rails server..."
docker-compose up rails

echo ""
echo "🎉 Chatwoot should be available at:"
echo "   Application: http://localhost:3000"
echo "   Mailhog:     http://localhost:8025"
echo ""
echo "To stop the application:"
echo "   docker-compose down"
