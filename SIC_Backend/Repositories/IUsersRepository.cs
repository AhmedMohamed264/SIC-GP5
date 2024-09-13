using SIC_Backend.Data.Models;

namespace SIC_Backend.Repositories
{
    public interface IUsersRepository
    {
        public Task<User> GetUserByIdAsync(string id);
        public Task<User> GetUserByUsernameAsync(string username);
        public Task<bool> IsUserNameAvailableAsync(string username);
        public Task<IEnumerable<NotificationToken>> GetNotificationTokens(string userId);
    }
}
