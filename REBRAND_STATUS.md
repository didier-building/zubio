# Zubio Rebrand Status

## Issue Identified & Resolved

### Problem
Chatwoot branding was reappearing in the application despite earlier rebrand efforts because the **database** still contained "Chatwoot" values in the `installation_configs` table.

### Root Cause
The `InstallationConfig` table stores system-wide configuration including:
- `BRAND_NAME` → Was set to "Chatwoot"
- `INSTALLATION_NAME` → Was set to "Chatwoot"

These database values override the YAML configuration files (`config/installation_config.yml`), which is why the Chatwoot branding kept reappearing after service restarts.

### Solution Applied

1. **Updated .env file**:
   - Changed `MAILER_SENDER_EMAIL` from "Chatwoot <accounts@zubio.com>" to "Zubio <accounts@zubio.com>"

2. **Updated .env.brand.example**:
   - Changed `POSTGRES_DATABASE` from "chatwoot" to "zubio" (example only, actual DB name unchanged)

3. **Ran database migrations**:
   ```bash
   docker-compose exec rails bundle exec rails db:migrate
   ```

4. **Updated InstallationConfig database records**:
   ```ruby
   InstallationConfig.find_or_create_by(name: 'BRAND_NAME').tap do |bn|
     bn.value = 'Zubio'
     bn.save!(validate: false)
   end

   InstallationConfig.find_or_create_by(name: 'INSTALLATION_NAME').tap do |in_name|
     in_name.value = 'Zubio'
     in_name.save!(validate: false)
   end
   ```

5. **Restarted services**:
   ```bash
   docker-compose restart rails sidekiq
   ```

## Verification

The application is now running at http://localhost:3000 with:
- ✅ Database BRAND_NAME = "Zubio"
- ✅ Database INSTALLATION_NAME = "Zubio"
- ✅ Environment variable MAILER_SENDER_EMAIL = "Zubio <accounts@zubio.com>"
- ✅ English i18n files updated
- ✅ Mailer templates updated
- ✅ Public assets (manifest.json, SVGs) updated
- ✅ CSS color overrides applied

## Remaining Occurrences (Expected)

The following "Chatwoot" references remain **by design** (as per user constraints):

### 1. Runtime Identifiers (Preserved)
- `window.chatwoot*` JavaScript objects
- `CHATWOOT_*` event constants
- Ruby module/class names like `ChatwootApp`, `ChatwootHub`
- Package names: `@chatwoot/*`

### 2. Non-Customer-Facing Content
- Code comments and documentation
- Third-party attribution notices
- Non-English locale files (community-managed per guidelines)
- Internal feature flags like `chatwoot_v4`, `chatwoot_internal`
- Development/test environment references

### 3. Database Schema & Help URLs
- Feature help URLs pointing to `https://chwt.app/hc/*` (upstream documentation)
- Some internal feature flag names stored in DB (e.g., `ACCOUNT_LEVEL_FEATURE_DEFAULTS`)

## Next Steps (Optional)

If complete removal of all Chatwoot references is desired:
1. Update help_url fields in `ACCOUNT_LEVEL_FEATURE_DEFAULTS` InstallationConfig
2. Consider self-hosting documentation and updating URLs
3. Update non-English locales (requires community translation)

## Commit History

- Updated .env MAILER_SENDER_EMAIL to Zubio
- Updated .env.brand.example POSTGRES_DATABASE to zubio
- Ran migrations and seeded InstallationConfig with Zubio branding

Date: 2025-01-XX
