import paho.mqtt.client as mqtt
import ssl

broker_URL = "b3ba351738c84951b2a48be602375fad.s1.eu.hivemq.cloud"
broker_port = 8883

client = mqtt.Client(client_id="Afifi1")

client.username_pw_set("ahmedafifi","Afifi@123")
client.tls_set(ca_certs=None, certfile=None, keyfile=None, cert_reqs=ssl.CERT_NONE, tls_version=ssl.PROTOCOL_TLSv1_2)
client.connect(broker_URL, broker_port)    
print("Connected on Broker !")

def on_message(client, userdata, message):
    print(f"Received message: {message.payload.decode()} on topic {message.topic}")

client.subscribe("earthquake")

client.on_message = on_message

client.loop_forever()