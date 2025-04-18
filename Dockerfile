# Stage 1: Node.js scraper
FROM node:18-slim AS scraper-stage


WORKDIR /app

RUN apt-get update && apt-get install -y \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libappindicator3-1 \
    libasound2 \
    libcups2 \
    libdbus-1-3 \
    libgdk-pixbuf2.0-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm-dev \
    && rm -rf /var/lib/apt/lists/*


RUN npm install puppeteer


COPY package.json package-lock.json ./
COPY scraper.js ./


RUN SCRAPE_URL="https://example.com" node scraper.js

# Stage 2: Python Flask server
FROM python:3.10-slim AS python-stage


WORKDIR /app


COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt


COPY --from=scraper-stage /app/scraped_data.json /app/scraped_data.json


COPY server.py ./


EXPOSE 5000

CMD ["python", "server.py"]
