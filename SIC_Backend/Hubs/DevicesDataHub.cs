using Microsoft.AspNetCore.SignalR;

namespace SIC_Backend.Hubs
{
    public class DevicesDataHub(ILogger<DevicesDataHub> logger) : Hub<IDeviceClient>
    {
        public async Task SubscribeToDevice(string deviceId)
        {
            logger.LogDebug($"Subscribing user {Context.ConnectionId} to device {deviceId}");
            await Groups.AddToGroupAsync(Context.ConnectionId, deviceId);
            logger.LogDebug($"User {Context.ConnectionId} subscribed to device {deviceId}");
        }

        public async Task UnsubscribeFromDevice(int deviceId)
        {
            logger.LogDebug($"Unsubscribing user {Context.ConnectionId} from device {deviceId}");
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, $"{deviceId}");
            logger.LogDebug($"User {Context.ConnectionId} unsubscribed from device {deviceId}");
        }

        public async Task RegisterTTS()
        {
            logger.LogDebug($"Registering TTS with id {Context.ConnectionId}");
            await Groups.AddToGroupAsync(Context.ConnectionId, "TTS");
            logger.LogDebug($"TTS with id {Context.ConnectionId} registered");
        }

        public async Task SubscribeToPin(int deviceId)
        {
            logger.LogDebug($"Registering device {deviceId} with id {Context.ConnectionId}");
            await Groups.AddToGroupAsync(Context.ConnectionId, $"{deviceId}");
            logger.LogDebug($"Device {deviceId} with id {Context.ConnectionId} registered");
        }

        public async Task SendDeviceData(int deviceId, object data)
        {
            logger.LogDebug($"Sending data to device {deviceId}");
            await Clients.Group($"{deviceId}").ReceiveData(data);
            logger.LogDebug($"Data sent to device {deviceId}");
        }
    }
}
