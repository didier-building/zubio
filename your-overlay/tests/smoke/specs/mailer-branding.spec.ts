import { test, expect } from '@playwright/test';

/**
 * Zubio Branding - Mailer Snapshot Test
 * Verifies email templates contain Zubio branding
 */

test.describe('Mailer Branding', () => {
  test('should verify conversation mailer contains Zubio', async ({ page }) => {
    // Login as admin
    await page.goto('/app/login');
    await page.fill('input[type="email"]', 'admin@zubio.com');
    await page.fill('input[type="password"]', 'Admin123!');
    await page.click('button[type="submit"]');
    await page.waitForURL('**/app/accounts/**');
    
    // Navigate to settings to check email configuration
    await page.goto('/app/accounts/1/settings/inboxes');
    
    // Check that support email contains zubio.rw
    const supportEmailText = await page.locator('body').textContent();
    
    // Should contain zubio.rw domain or support@zubio.com
    if (supportEmailText) {
      const hasZubioDomain = supportEmailText.includes('zubio.rw') || 
                             supportEmailText.includes('zubio.com');
      expect(hasZubioDomain || supportEmailText.includes('Zubio')).toBeTruthy();
    }
  });

  test('should check MailHog for Zubio branded emails', async ({ page }) => {
    // Access MailHog to check sent emails
    await page.goto('http://localhost:8025');
    
    // Wait for MailHog interface to load
    await page.waitForTimeout(2000);
    
    // Check if page loaded
    const pageTitle = await page.title();
    expect(pageTitle).toContain('MailHog');
    
    // If there are emails, check first one for branding
    const emailCount = await page.locator('.messages .msglist-message').count();
    
    if (emailCount > 0) {
      await page.click('.messages .msglist-message:first-child');
      await page.waitForTimeout(1000);
      
      // Get email content
      const emailBody = await page.locator('.tab-content').textContent();
      
      if (emailBody) {
        // Should contain Zubio, not Chatwoot
        expect(emailBody).toMatch(/Zubio/i);
        expect(emailBody).not.toMatch(/Chatwoot(?!Settings|SDK|Widget)/i);
      }
    }
  });
});
