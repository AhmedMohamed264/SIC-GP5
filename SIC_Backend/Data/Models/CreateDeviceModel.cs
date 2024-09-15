namespace SIC_Backend.Data.Models
{
    public class CreateDeviceModel
    {
        public required string Name { get; set; }
        public required DeviceDataTypes DataType { get; set; }
        public required string UserId { get; set; }
        public required int PlaceId { get; set; }
        public required int SectionId { get; set; }
        public required int Pin { get; set; }
    }
}