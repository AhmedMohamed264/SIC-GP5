import Adafruit_DHT
import time
from gpiozero import Buzzer
DHT_SENSOR = Adafruit_DHT.DHT11
DHT_PIN = 17
buzzer = Buzzer(27)
def Temprature():
    humidity,temprature = Adafruit_DHT.read(DHT_SENSOR,17)
    if temprature is not None:
        print(f"The current temprature is {temprature} celsius degrees")
        return temprature
    else:
        print(f"failed to get reading from DHT11 sensor!")
        return None
def BUZZER():
    print(f"High temprature!")
    buzzer.on()
    time.sleep(1)
    buzzer.off()
def monitor():
    while True:
        temprature=Temprature()
        if temprature is not None and temprature > 25:
            BUZZER()
        else:
            print(f"Normal temprature")
        time.sleep(3)
