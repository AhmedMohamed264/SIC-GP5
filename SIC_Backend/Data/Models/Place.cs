namespace SIC_Backend.Data.Models
{
    public class Place
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public required string UserId { get; set; }

        public User? User { get; set; }
        public ICollection<Section> Sections { get; set; } = [];
        public ICollection<Device> Devices { get; set; } = [];

        public static Place FromCreateModel(CreatePlaceModel model)
        {
            return new Place
            {
                Name = model.Name,
                UserId = model.UserId
            };
        }
    }
}
