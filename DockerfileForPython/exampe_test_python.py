import requests

response = requests.get("http://www.google.com")

if response.status_code == 200:
    print("Web-страница доступна")
else:
    print("Web-страница недоступна")
