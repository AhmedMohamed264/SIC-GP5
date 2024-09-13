using SIC_Backend.Data.Models;

namespace SIC_Backend.Repositories
{
    public interface IDevicesRepository
    {
        public Task<Device> GetDeviceByIdAsync(int id);
        public Task<IEnumerable<Device>> GetDevicesByUserIdAsync(string userId);
        public Task<IEnumerable<Device>> GetDevicesByPlaceIdAsync(int placeId);
        public Task<IEnumerable<Device>> GetDevicesBySectionIdAsync(int sectionId);
        public Task<Device> CreateDeviceAsync(CreateDeviceModel model);
        public Task<Device> UpdateDeviceAsync(int id, UpdateDeviceModel model);
        public Task DeleteDeviceAsync(int id);
    }
}
