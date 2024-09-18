from gpiozero import DistanceSensor, OutputDevice
from time import sleep

# Define GPIO pins
TRIG_PIN = 17  # Pin for TRIG on the ultrasonic sensor
ECHO_PIN = 18  # Pin for ECHO on the ultrasonic sensor
PUMP_PIN = 27  # Pin for controlling the water pump

# Set up the ultrasonic sensor and water pump
ultrasonic = DistanceSensor(echo=ECHO_PIN, trigger=TRIG_PIN)
pump = OutputDevice(PUMP_PIN, active_high=True, initial_value=False)

# Function to convert meters to centimeters
def distance_in_cm():
    return ultrasonic.distance * 100  # Convert meters to centimeters

# Main loop to control the pump based on the distance
try:
    while True:
        distance = distance_in_cm()
        print(f"Distance: {distance:.1f} cm")

        if distance < 20:
            print("Distance is less than 20 cm. Pump ON.")
            pump.on()
        else:
            print("Distance is more than 20 cm. Pump OFF.")
            pump.off()

        sleep(1)  # Wait for 1 second before taking the next reading

except KeyboardInterrupt:
    print("Program stopped")
    pump.off()  # Ensure the pump is turned off when the program stops
