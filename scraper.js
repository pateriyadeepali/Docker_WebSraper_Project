const puppeteer = require('puppeteer');

(async () => {
  const url = process.env.SCRAPE_URL || 'https://example.com'; // Use URL from environment variable or default
  const browser = await puppeteer.launch({ headless: true, args: ['--no-sandbox', '--disable-setuid-sandbox'] });
  const page = await browser.newPage();
  await page.goto(url);

  // Example: Scrape page title and first heading (h1)
  const data = await page.evaluate(() => {
    const title = document.title;
    const firstHeading = document.querySelector('h1') ? document.querySelector('h1').innerText : 'No heading found';
    return { title, firstHeading };
  });

  // Write scraped data to a file
  const fs = require('fs');
  fs.writeFileSync('scraped_data.json', JSON.stringify(data, null, 2));

  console.log('Scraping completed, data saved in scraped_data.json');
  await browser.close();
})();
