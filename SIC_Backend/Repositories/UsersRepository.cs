using Microsoft.EntityFrameworkCore;
using SIC_Backend.Data;
using SIC_Backend.Data.Models;

namespace SIC_Backend.Repositories
{
    public class UsersRepository(ApplicationDbContext dbContext) : IUsersRepository
    {
        public async Task<User> GetUserByIdAsync(string id)
        {
            var user = await dbContext.Users.FindAsync(id);

            if (user == null)
            {
                //throw new NotFoundException("User not found");
            }

            return user!;
        }

        public async Task<User> GetUserByUsernameAsync(string username)
        {
            var user = await dbContext.Users.FirstOrDefaultAsync(u => u.UserName == username);

            if (user == null)
            {
                //throw new NotFoundException("User not found");
            }

            return user!;
        }

        public async Task<bool> IsUserNameAvailableAsync(string username)
        {
            return await dbContext.Users.AllAsync(u => u.UserName != username);
        }

        public async Task<IEnumerable<NotificationToken>> GetNotificationTokens(string userId)
        {
            return await dbContext.NotificationTokens.Where(nt => nt.UserId == userId).ToListAsync();
        }
    }
}
