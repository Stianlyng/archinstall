import requests
import json

# Replace with the IP address of your Hue Bridge and your username
BRIDGE_IP = "192.168.1.57"
USERNAME = "govhnBiTPe8iX8ELInC3k3aaOHyCHT5BNmicHAei"

# Fetch all lights
response = requests.get(f"http://{BRIDGE_IP}/api/{USERNAME}/lights")
lights = json.loads(response.text)

# Turn off all lights
for light_id in lights.keys():
    url = f"http://{BRIDGE_IP}/api/{USERNAME}/lights/{light_id}/state"
    payload = json.dumps({"on": False})
    requests.put(url, data=payload)
