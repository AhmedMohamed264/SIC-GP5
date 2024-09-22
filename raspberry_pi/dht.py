import time
import ssl
import random
from gpiozero import Buzzer
import board
import adafruit_dht
import requests
import time

dht_device = adafruit_dht.DHT11(board.D17)
buzzer=Buzzer(27)
def sendData():
        while True:
                temperature = dht_device.temperature
                humidity = dht_device.humidity

                print(f"Temp: {temperature}C")
                print(f"Humidity: {humidity}%")
                if humidity > 54:
                        print(f"Warning! High humidity")
                        buzzer.on()
                        time.sleep(3)
                        buzzer.off()

                requests.post(f'http://ahmedafifi-lt:5283/Test/publish/9?data={temperature}')
                requests.post(f'http://ahmedafifi-lt:5283/Notifications/9?title=dht11&body=Warning+high+temprature')
                print("\n")

                time.sleep(1)


sendData()