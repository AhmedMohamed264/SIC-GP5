using SIC_Backend.Data.DTOs;
using SIC_Backend.Data.Models;

namespace SIC_Backend.Repositories
{
    public interface IUsersRepository
    {
        public UserDTO GetUserById(string id);
        public UserDTO GetUserByUsername(string username);
        public Task<bool> IsUserNameAvailableAsync(string username);
        public Task<IEnumerable<NotificationToken>> GetNotificationTokens(string userId);
    }
}
