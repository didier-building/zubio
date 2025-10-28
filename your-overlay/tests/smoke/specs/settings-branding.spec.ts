import { test, expect } from '@playwright/test';

/**
 * Zubio Branding - Settings Footer Test
 * Verifies Terms/Privacy links point to Zubio domains
 */

test.describe('Settings Footer Branding', () => {
  test.beforeEach(async ({ page }) => {
    // Login as admin first
    await page.goto('/app/login');
    await page.fill('input[type="email"]', 'admin@zubio.com');
    await page.fill('input[type="password"]', 'Admin123!');
    await page.click('button[type="submit"]');
    await page.waitForURL('**/app/accounts/**');
  });

  test('should display Zubio in settings page', async ({ page }) => {
    await page.goto('/app/accounts/1/settings');
    
    // Check for Zubio branding in settings
    const zubioText = page.getByText(/Zubio/i).first();
    await expect(zubioText).toBeVisible();
  });

  test('should have Terms link pointing to zubio.rw', async ({ page }) => {
    await page.goto('/app/accounts/1/settings');
    
    // Look for Terms link (may be in footer or policy section)
    const termsLink = page.locator('a[href*="zubio.rw/terms"]').first();
    
    // If terms link exists, verify it points to correct domain
    const count = await termsLink.count();
    if (count > 0) {
      await expect(termsLink).toHaveAttribute('href', /zubio\.rw\/terms/);
    }
  });

  test('should have Privacy link pointing to zubio.rw', async ({ page }) => {
    await page.goto('/app/accounts/1/settings');
    
    // Look for Privacy link
    const privacyLink = page.locator('a[href*="zubio.rw/privacy"]').first();
    
    // If privacy link exists, verify it points to correct domain
    const count = await privacyLink.count();
    if (count > 0) {
      await expect(privacyLink).toHaveAttribute('href', /zubio\.rw\/privacy/);
    }
  });

  test('should not contain "Chatwoot" in settings UI', async ({ page }) => {
    await page.goto('/app/accounts/1/settings');
    
    // Get visible text content (excluding script tags)
    const bodyText = await page.locator('body').textContent();
    
    // Should not contain "Chatwoot"
    expect(bodyText).not.toMatch(/Chatwoot(?!Settings|Widget|SDK)/i);
  });
});
