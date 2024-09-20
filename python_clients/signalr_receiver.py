import signalrcore
import signalrcore.hub_connection_builder
import time
import threading

hub_connection = signalrcore.hub_connection_builder.HubConnectionBuilder().with_url("http://ahmedafifi-lt:5283/DevicesDataHub").build()

hub_connection.on("ToSpeach", lambda x: print(x[0]))
# hub_connection.on("ReceiveData", print)

hub_connection.start()

hub_connection.on_open(lambda: register_tts(hub_connection))
# hub_connection.on_open(lambda: subscribe_to_pin(hub_connection, 0))

print("Connection started")

def subscribe_to_pin(connection, pin):
    connection.send("SubscribeToPin", arguments=[pin])

def register_tts(connection):
    connection.send("RegisterTTS", arguments=[])
    print("Registered TTS")

def infinite_loop():
    while True:
        pass

sleepThread = threading.Thread(target= infinite_loop)
sleepThread.start()