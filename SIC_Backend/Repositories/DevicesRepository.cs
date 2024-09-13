using Microsoft.EntityFrameworkCore;
using SIC_Backend.Data;
using SIC_Backend.Data.Models;

namespace SIC_Backend.Repositories
{
    public class DevicesRepository(ApplicationDbContext dbContext) : IDevicesRepository
    {
        public async Task<Device> GetDeviceByIdAsync(int id)
        {
            var device = await dbContext.Devices.FindAsync(id);

            if (device == null)
            {
                //throw new NotFoundException("Device not found");
            }

            return device!;
        }

        public async Task<IEnumerable<Device>> GetDevicesByUserIdAsync(string userId)
        {
            return await dbContext.Devices.Where(d => d.UserId == userId).ToListAsync();
        }

        public async Task<IEnumerable<Device>> GetDevicesByPlaceIdAsync(int placeId)
        {
            return await dbContext.Devices.Where(d => d.PlaceId == placeId).ToListAsync();
        }

        public async Task<IEnumerable<Device>> GetDevicesBySectionIdAsync(int sectionId)
        {
            return await dbContext.Devices.Where(d => d.SectionId == sectionId).ToListAsync();
        }

        public async Task<Device> CreateDeviceAsync(CreateDeviceModel model)
        {
            var device = Device.FromCreateModel(model);

            dbContext.Devices.Add(device);
            await dbContext.SaveChangesAsync();

            return device;
        }

        public async Task<Device> UpdateDeviceAsync(int id, UpdateDeviceModel model)
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

            return device!;
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
