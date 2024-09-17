using CloudinaryDotNet.Actions;

namespace SIC_Backend.Data.Models
{
    public enum DeviceDataTypes
    {
        Integer,
        Float,
        String,
        Boolean
    }

    public class Device
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public required DeviceDataTypes DataType { get; set; }
        public required string UserId { get; set; }
        public int SectionId { get; set; }
        public int PlaceId { get; set; }
        public int Pin { get; set; }

        public User? User { get; set; }
        public Section? Section { get; set; }
        public Place? Place { get; set; }

        public static Device FromCreateModel(CreateDeviceModel model)
        {
            return new Device
            {
                Name = model.Name,
                DataType = model.DataType,
                UserId = model.UserId,
                PlaceId = model.PlaceId,
                SectionId = model.SectionId,
                Pin = model.Pin
            };
        }
    }
}
