using Microsoft.EntityFrameworkCore;
using SIC_Backend.Data;
using SIC_Backend.Data.DTOs;
using SIC_Backend.Data.Models;

namespace SIC_Backend.Repositories
{
    public class UsersRepository(ApplicationDbContext dbContext) : IUsersRepository
    {
        public UserDTO GetUserById(string id)
        {
            var user = dbContext.Users.Where(u => u.Id == id)
                .Include(u => u.Places)
                .ThenInclude(p => p.Sections)
                .ThenInclude(s => s.Devices)
                .Select(UserDTO.FromUser)
                .First();

            return user;
        }

        public UserDTO GetUserByUsername(string username)
        {
            var user = dbContext.Users.Where(u => u.UserName == username)
                .Include(u => u.Places)
                .ThenInclude(p => p.Sections)
                .ThenInclude(s => s.Devices)
                .Select(UserDTO.FromUser)
                .First();

            return user;
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
