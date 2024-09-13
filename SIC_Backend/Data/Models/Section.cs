namespace SIC_Backend.Data.Models
{
    public class Section
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public required string UserId { get; set; }
        public int PlaceId { get; set; }

        public User? User { get; set; }
        public Place? Place { get; set; }
        public ICollection<Device> Devices { get; set; } = [];

        public static Section FromCreateModel(CreateSectionModel model)
        {
            return new Section
            {
                Name = model.Name,
                UserId = model.UserId,
                PlaceId = model.PlaceId
            };
        }
    }
}
