using SIC_Backend.Data.Models;

namespace SIC_Backend.Data.DTOs
{
    public class PlaceDTO
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public required string UserId { get; set; }

        public IEnumerable<SectionDTO> Sections { get; set; } = [];

        public static PlaceDTO FromPlace(Place place)
        {
            return new PlaceDTO
            {
                Id = place.Id,
                Name = place.Name,
                UserId = place.UserId,
                Sections = place.Sections.Select(SectionDTO.FromSection),
            };
        }
    }
}
