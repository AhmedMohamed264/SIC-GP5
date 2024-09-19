import requests
import random
import time

print("Enter pin number: ")
pin = input()

while True:
    randomNumber = random.uniform(0, 10)
    requests.post(f'http://ahmedafifi-lt:5283/Test/publish/float/{pin}?data={randomNumber}')
    print(f"Published {randomNumber}")
    time.sleep(1)