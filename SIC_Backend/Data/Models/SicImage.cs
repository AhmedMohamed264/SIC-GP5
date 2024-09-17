namespace SIC_Backend.Data.Models
{
    public class SicImage
    {
        public int Id { get; set; }
        public required string Url { get; set; }
        public DateTime TakenAt { get; set; }
        public int CameraId { get; set; }
    }
}
