using Microsoft.AspNetCore.SignalR;

namespace SIC_Backend.Hubs
{
    public class DevicesDataHub(ILogger<DevicesDataHub> logger) : Hub<IDeviceClient>
    {
        public async Task SubscribeToDevice(string connectionId, int deviceId)
        {
            logger.LogDebug($"Subscribing user {connectionId} to device {deviceId}");
            await Groups.AddToGroupAsync(connectionId, $"{deviceId}");
            logger.LogDebug($"User {connectionId} subscribed to device {deviceId}");
        }

        public async Task UnsubscribeFromDevice(string connectionId, int deviceId)
        {
            logger.LogDebug($"Unsubscribing user {connectionId} from device {deviceId}");
            await Groups.RemoveFromGroupAsync(connectionId, $"{deviceId}");
            logger.LogDebug($"User {connectionId} unsubscribed from device {deviceId}");
        }
    }
}
