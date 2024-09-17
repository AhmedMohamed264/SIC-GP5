using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NotificationService.Models;
using SIC_Backend.Data;

namespace SIC_Backend.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class NotificationsController(ApplicationDbContext dbContext, NotificationService.NotificationService notificationService) : ControllerBase
    {
        [HttpPost]
        [Route("{deviceId}")]
        public async Task<ActionResult >SendNotificationToDeviceOwner(int deviceId, string title, string body)
        {
            var user = await dbContext.Users.Where(u => u.Devices.Any(d => d.Id == deviceId)).Include(u => u.NotificationTokens).FirstAsync();

            if (user == null)
            {
                return NotFound();
            }

            IReadOnlyList<string> notificationTokens = user.NotificationTokens.Select(nt => nt.Token).ToList();

            //var notification = new MultipleUserNotification()
            //{
            //    Title = title,
            //    Body = body,
            //    Sender = "",
            //    Platform = Platform.Android,
            //    Recipients = notificationTokens,
            //};

            var notification = new SingleUserNotification()
            {
                Title = title,
                Body = body,
                Sender = "",
                Platform = Platform.Android,
                Recipient = notificationTokens.First(),
                RecipientType = RecipientType.User
            };

            await notificationService.SendNotificationAsync(notification);

            return Ok();
        }
    }
}
