# Docker Web Scraper Project
This project provides a simple Dockerized web scraper using Puppeteer and Flask. The scraper fetches data from a provided URL and returns the scraped content as a JSON response through a Flask API.

## Prerequisites

Make sure the following tools are installed on your system:
1. [Docker](https://docs.docker.com/get-docker/)
2. [Python](https://www.python.org/downloads/)
3. [Git](https://git-scm.com/)

 ## Project Structure  

 Below is a description of the main files used in this project and their responsibilities:

 ### 1. `scraper.js` 
- This file handles scraping using **Puppeteer** and **headless Chromium**.
- It takes the URL provided via the environment variable and scrapes the page.
- The scraped data is saved in a JSON file named `scraped_data.json`.

 -> Here is the file link from where you can get the code: 
 
 ---

 ### 2. `requirements.txt`
- Contains Python dependencies.
- Currently includes `Flask`, which is used to build the REST API.

---

### 3. `server.py`
- A simple **Flask API** that reads `scraped_data.json` and serves it at the root endpoint `/`.
- Once the container runs, this data will be accessible from a browser.

-> file link: 

---

### 4. `DockerFile`
We will make a multistage Dockerfile that will perform the following stages:
- First stage: Installs Node.js, Puppeteer, and runs scraper.js.
- Second stage: Sets up a lightweight Python environment to host the data using Flask.

Multi-stage builds help keep the final image small and efficient by copying only necessary files.
[View Dockerfile](./Dockerfile)

## Procedure to make a Docker image 

#### Step 1. Go inside the folder where the Dockerfile is located.
#### Step 2. Run the following command in the project directory 

bash
docker build -t scraper-app .

- This command builds the Docker image once this finishes, Docker will package up everything- Node.js for scraping, Python for serving.

---
  
## To run the container 

Once your Docker image is built, the next step is to actually run it — this will launch your scraper backend inside a container and host the data.

Below is the command we will use to run the container:

docker run -e SCRAPE_URL="https://example.com" -p 5000:5000 scraper-app

-> docker run – This starts a new container.
-> -e SCRAPE_URL="https://example.com" – where you pass the URL you want to scrape using an environment variable called SCRAPE_URL.
->  -p 5000:5000 – This maps port 5000 of the container to port 5000 on your machine, so you can access it in your browser.
->  scraper-app – This is the name of the image. 

After running this above command open the browser and put the url , you will see thescrappeddata in json format.

> http:localhost:5000

Note: If you are using ec2 instance of AWS, then you can also use the public IP of an instance.
Because in the server.py file, we have mentioned that this port is open for all IP.

We can also push this Docker image to Docker Hub.
Here are the following steps:

1. Log in to Docker Hub:
   You’ll be prompted to enter your Docker Hub username and password. (Make sure your Docker an 
   account is already created.)

  - docker login 

2. Tag your image
   Docker needs your image to have a specific name format before pushing:

 - docker tag scraper-app deepali2712/scraper-app

3. Push the image
   Upload your tagged image to Docker Hub:

 - docker push deepali2712/scraper-app

Now you can use this image whenever you need. 

---












 
 
