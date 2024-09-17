import requests
import random
import time

while True:
    randomNumber = random.uniform(0, 10)
    requests.post(f'http://ahmedafifi-pc:5283/Test/publish/float/1?data={randomNumber}')
    print(f"Published {randomNumber}")
    time.sleep(1)