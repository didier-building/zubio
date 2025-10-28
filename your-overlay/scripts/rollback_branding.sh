#!/bin/bash
set -euo pipefail

# Zubio Branding Rollback Script
# Reverts all white-label branding changes back to Chatwoot

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OVERLAY_ROOT="$(dirname "$SCRIPT_DIR")"
UPSTREAM_ROOT="$OVERLAY_ROOT/.."

echo "🔄 Zubio Branding Rollback"
echo "=========================="
echo ""
echo "This will revert all Zubio branding back to Chatwoot."
echo ""
read -p "Are you sure? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
  echo "❌ Rollback cancelled"
  exit 0
fi

echo ""
echo "📁 Step 1/4: Reverting locale files..."

# Revert all locale changes using git
cd "$UPSTREAM_ROOT"
git checkout -- app/javascript/dashboard/i18n/locale/ 2>/dev/null || echo "No locale changes to revert"
git checkout -- app/javascript/widget/i18n/ 2>/dev/null || echo "No widget locale changes to revert"

echo "📁 Step 2/4: Reverting view templates..."

# Revert all view/template changes
git checkout -- app/views/ 2>/dev/null || echo "No view changes to revert"

echo "📁 Step 3/4: Reverting entry point..."

# Revert dashboard entry point (CSS import)
git checkout -- app/javascript/entrypoints/dashboard.js 2>/dev/null || echo "No entry point changes to revert"

echo "📁 Step 4/4: Removing copied assets..."

# Remove copied logo files
rm -f "$UPSTREAM_ROOT/app/javascript/dashboard/assets/images/logo.svg"
rm -f "$UPSTREAM_ROOT/app/javascript/dashboard/assets/images/logo-dark.svg"
rm -f "$UPSTREAM_ROOT/app/javascript/widget/assets/images/logo.svg"
rm -f "$UPSTREAM_ROOT/public/favicon.png"
rm -f "$UPSTREAM_ROOT/public/apple-touch-icon.png"

# Remove brand CSS
rm -f "$UPSTREAM_ROOT/app/javascript/dashboard/assets/scss/zubio-overrides.css"

# Clean up any .bak files
find "$UPSTREAM_ROOT" -name "*.bak" -delete 2>/dev/null || true

echo ""
echo "✅ Rollback complete!"
echo ""
echo "Next steps:"
echo "  1. Rebuild frontend: pnpm build"
echo "  2. Restart app: docker-compose restart rails vite"
echo "  3. Clear browser cache and refresh"
echo ""
echo "To reapply branding later:"
echo "  bash your-overlay/scripts/apply_branding.sh"
