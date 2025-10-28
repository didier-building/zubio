# Zubio Smoke Tests

Playwright-based smoke tests to verify white-label branding is visible across customer-facing UI.

## What's Tested

1. **Login Page**: Product name in title, logo visible, no "Chatwoot" text
2. **Settings Footer**: Terms/Privacy links point to zubio.rw domains
3. **Widget**: Widget loads with Zubio logo and brand colors
4. **Mailer**: Email templates contain Zubio branding, not Chatwoot

## Setup

```bash
cd your-overlay/tests/smoke
pnpm install
```

## Run Tests

```bash
# Run all tests (headless)
pnpm test

# Run with UI
pnpm test:ui

# Run in headed mode (see browser)
pnpm test:headed

# View last test report
pnpm test:report
```

## CI Integration

These tests run automatically in `.github/workflows/brand-build.yml` after applying branding overlay.

## Prerequisites

- App running at http://localhost:3000
- Admin user: admin@zubio.com / Admin123!
- MailHog running at http://localhost:8025

## Test Files

- `specs/login-branding.spec.ts` - Login page branding
- `specs/settings-branding.spec.ts` - Settings footer links
- `specs/widget-branding.spec.ts` - Widget logo and colors
- `specs/mailer-branding.spec.ts` - Email template branding
