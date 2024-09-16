import serial
import time
from gpiozero import DistanceSensor, LED
from time import sleep

class TTSSpeaker:
    # Bismillah
    def __init__(self, port='/dev/ttyAMA0', baud_rate=115200, timeout=1):
        self.ttsSerial = serial.Serial(port, baud_rate, timeout=timeout)
        time.sleep(2) 

    def check_response(self):
        # checks if tts is ready/failed/busy
        response = self.ttsSerial.read(1)
        if response:
            print(f"Response: {response.hex()}")  # tts status
        return response == b'\x41'

    def set_volume(self, volume):
        # Volume 0 to 9
        if 0 <= volume <= 9:
            query = bytearray([0x5B, 0x76, 0x30 + volume, 0x5D])
            self.ttsSerial.write(query)
            return self.check_response()
        else:
            raise ValueError("Volume must be between 0 and 9")

    def send_text(self, message):
        # give tts a text to speak
        length = len(message) + 2
        encoded = bytearray([0xFD, (length >> 8) & 0xFF, length & 0xFF, 0x01, 0x01])
        encoded.extend(message.encode('ascii'))
        self.ttsSerial.write(encoded)
        return self.check_response()

    def is_idle(self):
        # checks if tts is ready/failed/busy (part 2)
        query = bytearray([0xFD, 0x00, 0x01, 0x21])
        self.ttsSerial.write(query)
        response = self.ttsSerial.read(1)
        if response == b'\x4E':
            return "m_busy"
        elif response == b'\x4F':
            return "m_idle"
        else:
            return "m_error"

# Ultrasonic and LED Lamp
class SmartHome:
    def __init__(self, trigger_pin, echo_pin, led_pin):
        # Bismillah
        self.sensor = DistanceSensor(echo=echo_pin, trigger=trigger_pin, max_distance=2)
        self.led = LED(led_pin)

    def get_distance(self):
        # Return distance in cm
        distance_m = self.sensor.distance  # This gives distance in meters
        distance_cm = distance_m * 100  # Convert to cm
        print(f"Distance: {distance_cm:.2f} cm")
        return distance_cm

    def turn_led_on(self):
        self.led.on()

    def turn_led_off(self):
        self.led.off()

# testing
if __name__ == "__main__":
    tts = TTSSpeaker(port='/dev/ttyAMA0', baud_rate=115200)
    smarthome = SmartHome(trigger_pin=17, echo_pin=18, led_pin=21)

    tts.set_volume(5)    # Set the volume(probably not working :clown_emoji:)

    while True:
        distance = smarthome.get_distance()

        if distance < 30:
            print("Motion detected!")
            tts.send_text("Motion detected")
            smarthome.turn_led_on()
            sleep(4)
            smarthome.turn_led_off()

        sleep(1)
