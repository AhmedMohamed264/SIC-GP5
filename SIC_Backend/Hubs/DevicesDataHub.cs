using Microsoft.AspNetCore.SignalR;

namespace SIC_Backend.Hubs
{
    public class DevicesDataHub(ILogger<DevicesDataHub> logger) : Hub<IDeviceClient>
    {
        public async Task SubscribeToDevice(string connectionId, string deviceId)
        {
            logger.LogDebug($"Subscribing user {connectionId} to device {deviceId}");
            await Groups.AddToGroupAsync(connectionId, deviceId);
            logger.LogDebug($"User {connectionId} subscribed to device {deviceId}");
        }

        public async Task UnsubscribeFromDevice(string connectionId, int deviceId)
        {
            logger.LogDebug($"Unsubscribing user {connectionId} from device {deviceId}");
            await Groups.RemoveFromGroupAsync(connectionId, $"{deviceId}");
            logger.LogDebug($"User {connectionId} unsubscribed from device {deviceId}");
        }

        public async Task RegisterTTS()
        {
            logger.LogDebug($"Registering TTS with id {Context.ConnectionId}");
            await Groups.AddToGroupAsync(Context.ConnectionId, "TTS");
            logger.LogDebug($"TTS with id {Context.ConnectionId} registered");
        }
    }
}
