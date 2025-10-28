# Zubio Branding Overlay

This directory contains all white-label branding for Zubio, applied non-invasively over Chatwoot upstream code.

## Structure

```
your-overlay/
├── assets/
│   ├── dashboard/         # Dashboard logos, favicons
│   ├── widget/            # Widget icons
│   └── styles/            # Brand CSS overrides
├── scripts/
│   ├── apply_branding.sh  # Apply overlay (idempotent)
│   └── audit_leftovers.sh # Check for missed rebrand items
├── docs/
│   └── THIRD_PARTY_NOTICES.md
└── brand.json             # Single source of truth for all brand values
```

## Quick Start

### 1. Apply Branding

```bash
bash your-overlay/scripts/apply_branding.sh
```

### 2. Audit for Leftovers

```bash
bash your-overlay/scripts/audit_leftovers.sh
```

### 3. Rebuild Frontend

```bash
docker-compose restart vite rails
```

## Brand Configuration

All brand values are in `brand.json`:
- Product name, company name
- Domain URLs (app, API, privacy, terms)
- Brand colors
- Support emails

## Upgrade Process

When pulling Chatwoot upstream updates:

1. `git pull upstream main` (or merge upstream changes)
2. `bash your-overlay/scripts/apply_branding.sh`
3. `bash your-overlay/scripts/audit_leftovers.sh`
4. Test in browser
5. Commit overlay application

## CI/CD

GitHub Actions workflow (`.github/workflows/brand-build.yml`) runs on every push:
- Applies branding
- Builds frontend
- Runs audit (fails if leftovers found)

## License

This overlay is proprietary to Zubio Ltd. The underlying Chatwoot code is MIT-licensed (see `THIRD_PARTY_NOTICES.md`).
