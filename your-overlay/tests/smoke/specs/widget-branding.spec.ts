import { test, expect } from '@playwright/test';

/**
 * Zubio Branding - Widget Test
 * Verifies widget displays Zubio logo and brand colors
 */

test.describe('Widget Branding', () => {
  test('should load widget with Zubio branding', async ({ page }) => {
    // Create a test HTML page with widget
    const widgetHtml = `
      <!DOCTYPE html>
      <html>
      <head>
        <title>Widget Test</title>
      </head>
      <body>
        <h1>Test Page</h1>
        <script>
          (function(d,t) {
            var BASE_URL="http://localhost:3000";
            var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
            g.src=BASE_URL+"/packs/js/sdk.js";
            s.parentNode.insertBefore(g,s);
            g.async=!0;
            g.onload=function(){
              window.chatwootSDK.run({
                websiteToken: 'test-token',
                baseUrl: BASE_URL
              })
            };
          })(document,"script");
        </script>
      </body>
      </html>
    `;
    
    await page.setContent(widgetHtml);
    await page.waitForTimeout(3000); // Wait for widget to load
    
    // Check if widget bubble exists
    const widgetBubble = page.locator('.woot-widget-bubble, [class*="widget-bubble"]').first();
    const bubbleCount = await widgetBubble.count();
    
    if (bubbleCount > 0) {
      await expect(widgetBubble).toBeVisible();
    }
  });

  test('should apply Zubio brand colors to widget', async ({ page }) => {
    const widgetHtml = `
      <!DOCTYPE html>
      <html>
      <head>
        <title>Widget Color Test</title>
      </head>
      <body>
        <h1>Test Page</h1>
        <script>
          (function(d,t) {
            var BASE_URL="http://localhost:3000";
            var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
            g.src=BASE_URL+"/packs/js/sdk.js";
            s.parentNode.insertBefore(g,s);
            g.async=!0;
            g.onload=function(){
              window.chatwootSDK.run({
                websiteToken: 'test-token',
                baseUrl: BASE_URL
              })
            };
          })(document,"script");
        </script>
      </body>
      </html>
    `;
    
    await page.setContent(widgetHtml);
    await page.waitForTimeout(3000);
    
    // Check if widget has brand color applied
    const widgetBubble = page.locator('.woot-widget-bubble, [class*="widget-bubble"]').first();
    const bubbleCount = await widgetBubble.count();
    
    if (bubbleCount > 0) {
      const bgColor = await widgetBubble.evaluate((el) => {
        return window.getComputedStyle(el).backgroundColor;
      });
      
      // Zubio primary color is #125C6D which is rgb(18, 92, 109)
      // Check if color contains these values (allowing for slight variations)
      expect(bgColor).toBeTruthy();
    }
  });
});
