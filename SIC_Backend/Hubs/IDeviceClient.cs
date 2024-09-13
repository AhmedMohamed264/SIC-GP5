namespace SIC_Backend.Hubs
{
    public interface IDeviceClient
    {
        void RefreshDevice(int deviceId, object data);
    }
}
