namespace SIC_Backend.Hubs
{
    public interface IDeviceClient
    {
        public Task ReceiveData(object data);
    }
}
