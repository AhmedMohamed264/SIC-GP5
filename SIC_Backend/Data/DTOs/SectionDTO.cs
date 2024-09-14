using SIC_Backend.Data.Models;

namespace SIC_Backend.Data.DTOs
{
    public class SectionDTO
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public required string UserId { get; set; }
        public int PlaceId { get; set; }

        public IEnumerable<DeviceDTO> Devices { get; set; } = [];

        public static SectionDTO FromSection(Section section)
        {
            return new SectionDTO
            {
                Id = section.Id,
                Name = section.Name,
                UserId = section.UserId,
                PlaceId = section.PlaceId,
                Devices = section.Devices.Select(DeviceDTO.FromDevice),
            };
        }
    }
}
