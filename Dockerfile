# Stage 1: Node.js scraper
FROM node:18-slim AS scraper-stage

# Set working directory for Node.js
WORKDIR /app

# Install required dependencies for Puppeteer and Chromium
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

# Install Puppeteer
RUN npm install puppeteer

# Copy package.json and scrape.js script
COPY package.json package-lock.json ./
COPY scraper.js ./

# Run the scraper script
RUN SCRAPE_URL="https://example.com" node scraper.js

# Stage 2: Python Flask server
FROM python:3.10-slim AS python-stage

# Set working directory for Flask
WORKDIR /app

# Install Flask and other Python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the scraped data from the first stage
COPY --from=scraper-stage /app/scraped_data.json /app/scraped_data.json

# Copy the Flask server code
COPY server.py ./

# Expose port for the Flask app
EXPOSE 5000

# Run the Flask app
CMD ["python", "server.py"]
