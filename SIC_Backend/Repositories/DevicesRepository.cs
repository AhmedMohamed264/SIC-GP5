using Microsoft.EntityFrameworkCore;
using SIC_Backend.Data;
using SIC_Backend.Data.DTOs;
using SIC_Backend.Data.Models;

namespace SIC_Backend.Repositories
{
    public class DevicesRepository(ApplicationDbContext dbContext) : IDevicesRepository
    {
        public async Task<DeviceDTO> GetDeviceByIdAsync(int id)
        {
            var device = await dbContext.Devices.FindAsync(id);

            if (device == null)
            {
                //throw new NotFoundException("Device not found");
            }

            return DeviceDTO.FromDevice(device!);
        }

        public IEnumerable<DeviceDTO> GetDevicesByUserId(string userId)
        {
            return dbContext.Devices.Where(d => d.UserId == userId)
                .Select(DeviceDTO.FromDevice)
                .ToList();
        }

        public IEnumerable<DeviceDTO> GetDevicesByPlaceId(int placeId)
        {
            return dbContext.Devices.Where(d => d.PlaceId == placeId)
                .Select(DeviceDTO.FromDevice)
                .ToList();
        }

        public IEnumerable<DeviceDTO> GetDevicesBySectionId(int sectionId)
        {
            return dbContext.Devices.Where(d => d.SectionId == sectionId)
                .Select(DeviceDTO.FromDevice)
                .ToList();
        }

        public async Task CreateDeviceAsync(CreateDeviceModel model)
        {
            var device = Device.FromCreateModel(model);

            dbContext.Devices.Add(device);
            
            await dbContext.SaveChangesAsync();
        }

        public async Task UpdateDeviceAsync(int id, UpdateDeviceModel model)
        {
            var device = await dbContext.Devices.FindAsync(id);

            if (device == null)
            {
                //throw new NotFoundException("Device not found");
            }

            device!.Name = model.Name;
            device.PlaceId = model.PlaceId;
            device.SectionId = model.SectionId;

            await dbContext.SaveChangesAsync();
        }

        public async Task DeleteDeviceAsync(int id)
        {
            var device = await dbContext.Devices.FindAsync(id);

            if (device == null)
            {
                //throw new NotFoundException("Device not found");
            }

            dbContext.Devices.Remove(device!);
        }
    }
}
