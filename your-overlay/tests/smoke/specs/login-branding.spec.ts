import { test, expect } from '@playwright/test';

/**
 * Zubio Branding - Login Page Test
 * Verifies product name and logo are visible on login page
 */

test.describe('Login Page Branding', () => {
  test('should display Zubio product name in page title', async ({ page }) => {
    await page.goto('/app/login');
    
    // Check page title contains "Zubio"
    await expect(page).toHaveTitle(/Zubio/);
  });

  test('should display Zubio logo on login page', async ({ page }) => {
    await page.goto('/app/login');
    
    // Check for logo image
    const logo = page.locator('img[alt*="logo" i], img[src*="logo"]').first();
    await expect(logo).toBeVisible();
  });

  test('should not contain "Chatwoot" text on login page', async ({ page }) => {
    await page.goto('/app/login');
    
    // Get all text content
    const bodyText = await page.locator('body').textContent();
    
    // Assert no "Chatwoot" references
    expect(bodyText).not.toMatch(/Chatwoot/i);
  });

  test('should display Zubio in any visible text', async ({ page }) => {
    await page.goto('/app/login');
    
    // Check that "Zubio" appears somewhere on the page
    const zubioText = page.getByText(/Zubio/i).first();
    await expect(zubioText).toBeVisible();
  });
});
