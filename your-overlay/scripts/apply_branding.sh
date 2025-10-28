#!/bin/bash
set -euo pipefail

# Zubio Branding Overlay Application Script
# Applies white-label branding to Chatwoot upstream code

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OVERLAY_ROOT="$(dirname "$SCRIPT_DIR")"
UPSTREAM_ROOT="$OVERLAY_ROOT/.."
BRAND_JSON="$OVERLAY_ROOT/brand.json"

echo "🎨 Zubio Branding Overlay Application"
echo "======================================="

# Check if brand.json exists
if [ ! -f "$BRAND_JSON" ]; then
  echo "❌ Error: brand.json not found at $BRAND_JSON"
  exit 1
fi

# Check if jq is installed
if ! command -v jq &> /dev/null; then
  echo "❌ Error: jq is required but not installed"
  echo "   Install: sudo apt-get install jq"
  exit 1
fi

# Extract brand values using jq
PRODUCT_NAME=$(jq -r '.productName' "$BRAND_JSON")
COMPANY_NAME=$(jq -r '.companyName' "$BRAND_JSON")
SUPPORT_EMAIL=$(jq -r '.emails.support' "$BRAND_JSON")
PRIVACY_URL=$(jq -r '.domains.privacy' "$BRAND_JSON")
TERMS_URL=$(jq -r '.domains.terms' "$BRAND_JSON")

echo "📦 Product: $PRODUCT_NAME"
echo "🏢 Company: $COMPANY_NAME"
echo ""

# Step 1: Copy Dashboard Assets
echo "📁 Step 1/6: Copying dashboard assets..."
mkdir -p "$UPSTREAM_ROOT/app/javascript/dashboard/assets/images"
cp -v "$OVERLAY_ROOT/assets/dashboard/logo.svg" "$UPSTREAM_ROOT/app/javascript/dashboard/assets/images/logo.svg"
cp -v "$OVERLAY_ROOT/assets/dashboard/logo-dark.svg" "$UPSTREAM_ROOT/app/javascript/dashboard/assets/images/logo-dark.svg"

# Copy favicons to public
mkdir -p "$UPSTREAM_ROOT/public"
if [ -f "$OVERLAY_ROOT/assets/dashboard/favicon.png" ]; then
  cp -v "$OVERLAY_ROOT/assets/dashboard/favicon.png" "$UPSTREAM_ROOT/public/favicon.png"
fi
if [ -f "$OVERLAY_ROOT/assets/dashboard/apple-touch-icon.png" ]; then
  cp -v "$OVERLAY_ROOT/assets/dashboard/apple-touch-icon.png" "$UPSTREAM_ROOT/public/apple-touch-icon.png"
fi

# Step 2: Copy Widget Assets
echo "📁 Step 2/6: Copying widget assets..."
mkdir -p "$UPSTREAM_ROOT/app/javascript/widget/assets/images"
cp -v "$OVERLAY_ROOT/assets/widget/widget-logo.svg" "$UPSTREAM_ROOT/app/javascript/widget/assets/images/logo.svg"

# Step 3: Copy Brand CSS
echo "🎨 Step 3/6: Applying brand CSS..."
mkdir -p "$UPSTREAM_ROOT/app/javascript/dashboard/assets/scss"
cp -v "$OVERLAY_ROOT/assets/styles/zubio-overrides.css" "$UPSTREAM_ROOT/app/javascript/dashboard/assets/scss/zubio-overrides.css"

# Add import to main dashboard entry if not already present
DASHBOARD_ENTRY="$UPSTREAM_ROOT/app/javascript/dashboard/dashboard.js"
if [ -f "$DASHBOARD_ENTRY" ]; then
  if ! grep -q "zubio-overrides.css" "$DASHBOARD_ENTRY"; then
    echo "import './assets/scss/zubio-overrides.css';" >> "$DASHBOARD_ENTRY"
    echo "✅ Added CSS import to dashboard.js"
  else
    echo "✅ CSS import already exists in dashboard.js"
  fi
fi

# Step 4: Replace strings in locales (customer-visible only)
echo "🌐 Step 4/6: Replacing product name in locales..."

# Dashboard locales
if [ -d "$UPSTREAM_ROOT/app/javascript/dashboard/i18n/locale" ]; then
  find "$UPSTREAM_ROOT/app/javascript/dashboard/i18n/locale" -name "*.json" -type f | while read -r file; do
    if grep -q "Chatwoot" "$file"; then
      sed -i.bak "s/Chatwoot/$PRODUCT_NAME/g" "$file"
      echo "  ✓ Updated: $(basename "$file")"
    fi
  done
fi

# Widget locales (if present)
if [ -d "$UPSTREAM_ROOT/app/javascript/widget/i18n" ]; then
  find "$UPSTREAM_ROOT/app/javascript/widget/i18n" -name "*.json" -type f | while read -r file; do
    if grep -q "Chatwoot" "$file"; then
      sed -i.bak "s/Chatwoot/$PRODUCT_NAME/g" "$file"
      echo "  ✓ Updated: $(basename "$file")"
    fi
  done
fi

# Step 5: Update mailer templates
echo "📧 Step 5/6: Updating mailer templates..."
if [ -d "$UPSTREAM_ROOT/app/views" ]; then
  find "$UPSTREAM_ROOT/app/views" -type f \( -name "*.html.erb" -o -name "*.text.erb" \) | while read -r file; do
    if grep -q "Chatwoot" "$file"; then
      sed -i.bak \
        -e "s/Chatwoot/$PRODUCT_NAME/g" \
        -e "s/support@chatwoot.com/$SUPPORT_EMAIL/g" \
        "$file"
      echo "  ✓ Updated: $(basename "$file")"
    fi
  done
fi

# Step 6: Update page titles in layouts
echo "📄 Step 6/6: Updating page titles..."
if [ -d "$UPSTREAM_ROOT/app/views/layouts" ]; then
  find "$UPSTREAM_ROOT/app/views/layouts" -name "*.html.erb" -type f | while read -r file; do
    if grep -q "<title>.*Chatwoot" "$file"; then
      sed -i.bak "s/<title>.*Chatwoot.*<\/title>/<title>$PRODUCT_NAME<\/title>/g" "$file"
      echo "  ✓ Updated: $(basename "$file")"
    fi
  done
fi

# Clean up backup files
find "$UPSTREAM_ROOT" -name "*.bak" -delete 2>/dev/null || true

echo ""
echo "✅ Branding overlay applied successfully!"
echo ""
echo "Next steps:"
echo "  1. Review changes: git diff"
echo "  2. Run audit: bash $OVERLAY_ROOT/scripts/audit_leftovers.sh"
echo "  3. Rebuild frontend: docker-compose restart vite"
echo "  4. Test in browser: http://localhost:3000"
