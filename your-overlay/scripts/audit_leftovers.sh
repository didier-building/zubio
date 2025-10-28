#!/bin/bash
set -euo pipefail

# Zubio Branding Audit Script
# Checks for remaining "Chatwoot" references in customer-visible files

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OVERLAY_ROOT="$(dirname "$SCRIPT_DIR")"
UPSTREAM_ROOT="$OVERLAY_ROOT/.."

echo "🔍 Zubio Branding Audit"
echo "======================="
echo ""

# Check if rg (ripgrep) is installed, fallback to grep
if command -v rg &> /dev/null; then
  SEARCH_CMD="rg"
else
  SEARCH_CMD="grep -r"
  echo "⚠️  ripgrep not found, using grep (slower)"
fi

# Directories to check (customer-visible only)
SEARCH_PATHS=(
  "$UPSTREAM_ROOT/app/javascript/dashboard/i18n"
  "$UPSTREAM_ROOT/app/javascript/widget"
  "$UPSTREAM_ROOT/app/views"
  "$UPSTREAM_ROOT/public"
)

# Patterns to search for
PATTERNS=("Chatwoot" "chatwoot.com" "Captain")

FOUND_ISSUES=0

for path in "${SEARCH_PATHS[@]}"; do
  if [ ! -d "$path" ]; then
    echo "⚠️  Path not found: $path (skipping)"
    continue
  fi
  
  echo "Scanning: $path"
  
  for pattern in "${PATTERNS[@]}"; do
    # Search but exclude node_modules, dist, build, spec, packs, assets
    if [ "$SEARCH_CMD" = "rg" ]; then
      results=$(rg -i "$pattern" "$path" \
        --glob '!node_modules/**' \
        --glob '!dist/**' \
        --glob '!build/**' \
        --glob '!spec/**' \
        --glob '!packs/**' \
        --glob '!assets/**' \
        --glob '!*.bak' \
        2>/dev/null || true)
    else
      results=$(grep -ri "$pattern" "$path" \
        --exclude-dir=node_modules \
        --exclude-dir=dist \
        --exclude-dir=build \
        --exclude-dir=spec \
        --exclude-dir=packs \
        --exclude-dir=assets \
        --exclude="*.bak" \
        2>/dev/null || true)
    fi
    
    if [ -n "$results" ]; then
      # Filter out acceptable technical references
      filtered_results=$(echo "$results" | \
        grep -v "chatwoot.help" | \
        grep -v "window.chatwootSettings" | \
        grep -v "window.\$chatwoot" | \
        grep -v "UPDATE_CHATWOOT" | \
        grep -v "/public/packs/" | \
        grep -v "/public/assets/" || true)
      
      if [ -n "$filtered_results" ]; then
        echo ""
        echo "❌ Found '$pattern' in:"
        echo "$filtered_results"
        echo ""
        FOUND_ISSUES=$((FOUND_ISSUES + 1))
      fi
    fi
  done
done

echo ""
if [ $FOUND_ISSUES -eq 0 ]; then
  echo "✅ No branding leftovers found! All clear."
  exit 0
else
  echo "❌ Found $FOUND_ISSUES branding issues"
  echo "   Run 'bash your-overlay/scripts/apply_branding.sh' to fix"
  exit 1
fi
