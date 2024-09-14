using SIC_Backend.Data.DTOs;
using SIC_Backend.Data.Models;

namespace SIC_Backend.Repositories
{
    public interface IDevicesRepository
    {
        public Task<DeviceDTO> GetDeviceByIdAsync(int id);
        public IEnumerable<DeviceDTO> GetDevicesByUserId(string userId);
        public IEnumerable<DeviceDTO> GetDevicesByPlaceId(int placeId);
        public IEnumerable<DeviceDTO> GetDevicesBySectionId(int sectionId);
        public Task CreateDeviceAsync(CreateDeviceModel model);
        public Task UpdateDeviceAsync(int id, UpdateDeviceModel model);
        public Task DeleteDeviceAsync(int id);
    }
}
