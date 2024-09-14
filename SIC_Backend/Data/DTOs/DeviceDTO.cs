using SIC_Backend.Data.Models;

namespace SIC_Backend.Data.DTOs
{
    public class DeviceDTO
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public required DeviceDataTypes DataType { get; set; }
        public required string UserId { get; set; }
        public int SectionId { get; set; }
        public int PlaceId { get; set; }

        public static DeviceDTO FromDevice(Device device)
        {
            return new DeviceDTO
            {
                Id = device.Id,
                Name = device.Name,
                DataType = device.DataType,
                UserId = device.UserId,
                SectionId = device.SectionId,
                PlaceId = device.PlaceId
            };
        }
    }
}
