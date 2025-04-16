from flask import Flask, jsonify
import json

app = Flask(__name__)

# Endpoint to return scraped data
@app.route('/')
def get_scraped_data():
    try:
        # Open and load the scraped data
        with open('scraped_data.json', 'r') as file:
            data = json.load(file)
        return jsonify(data)  # Return the data as JSON
    except FileNotFoundError:
        return jsonify({"error": "Scraped data not found"}), 404

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
