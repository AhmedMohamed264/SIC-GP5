namespace SIC_Backend.Data.Models
{
    public class UpdateDeviceModel
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public required string DataType { get; set; }
        public int PlaceId { get; set; }
        public int SectionId { get; set; }
    }
}