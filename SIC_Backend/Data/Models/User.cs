using Microsoft.AspNetCore.Identity;

namespace SIC_Backend.Data.Models
{
    public class User : IdentityUser
    {
        public required string FirstName { get; set; }
        public required string LastName { get; set; }

        public ICollection<Place> Places { get; set; } = [];
        public ICollection<Section> Sections { get; set; } = [];
        public ICollection<Device> Devices { get; set; } = [];
        public ICollection<NotificationToken> NotificationTokens { get; set; } = [];

        public static User FromRegisterModel(RegisterModel model)
        {
            return new User
            {
                UserName = model.Username,
                Email = model.Email,
                FirstName = model.FirstName,
                LastName = model.LastName
            };
        }
    }
}
