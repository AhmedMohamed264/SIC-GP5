using NotificationService.Models;

namespace SIC_Backend.Data.Models;

public class NotificationTokenModel
{
    public required string Token { get; set; }
    public required string UserId { get; set; }
    public required Platform Platform { get; set; }
}
