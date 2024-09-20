import signalrcore
import signalrcore.hub_connection_builder
import time
import threading
import random

hub_connection = signalrcore.hub_connection_builder.HubConnectionBuilder().with_url("http://ahmedafifi-lt:5283/DevicesDataHub").build()

hub_connection.start()

hub_connection.on_open(lambda: mainLoop())

print("Connection started")

def sendData(pin, data):
    hub_connection.send("SendDeviceData", arguments=[pin, data])
    print(f"Sent {data}")

def mainLoop():
    while True:
        # randomNumber = random.uniform(0, 100)
        # sendData(2, randomNumber)
        sendData("TTS", "Hello")
        time.sleep(1)

def infinite_loop():
    while True:
        pass

sleepThread = threading.Thread(target= infinite_loop)
sleepThread.start()