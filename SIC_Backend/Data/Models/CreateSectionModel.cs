namespace SIC_Backend.Data.Models
{
    public class CreateSectionModel
    {
        public required string Name { get; set; }
        public required string UserId { get; set; }
        public int PlaceId { get; set; }
    }
}