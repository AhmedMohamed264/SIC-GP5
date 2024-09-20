import requests

url = 'http://ahmedafifi-lt:5000/detect'

files = {'img': open('C:\\Users\Ahmed\\assignment3\\people.jpg', 'rb')}

response = requests.post(url, files=files)

print(response.text)