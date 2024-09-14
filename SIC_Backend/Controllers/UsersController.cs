using Microsoft.AspNetCore.Mvc;
using SIC_Backend.Data.DTOs;
using SIC_Backend.Data.Models;
using SIC_Backend.Repositories;

namespace SIC_Backend.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UsersController(IUsersRepository usersRepository, ILogger<UsersController> logger) : ControllerBase
    {
        [HttpGet]
        [Route("{id}")]
        public ActionResult<UserDTO> GetUserById(string id)
        {
            logger.LogDebug("UsersController -> GetUserByIdAsync: getting user by id");
            var user = usersRepository.GetUserById(id);
            return Ok(user);
        }

        [HttpGet]
        [Route("UserName/{username}")]
        public ActionResult<UserDTO> GetUserByUsername(string username)
        {
            logger.LogDebug("UsersController -> GetUserByUsernameAsync: getting user by username");
            var user = usersRepository.GetUserByUsername(username);
            return Ok(user);
        }

        [HttpGet]
        [Route("IsUserNameAvailable/{username}")]
        public async Task<ActionResult<bool>> IsUserNameAvailable(string username)
        {
            logger.LogDebug("UsersController -> IsUserNameAvailableAsync: checking if username is available");
            var isAvailable = await usersRepository.IsUserNameAvailableAsync(username);
            return Ok(isAvailable);
        }

        [HttpGet]
        [Route("NotificationTokens/{userId}")]
        public async Task<ActionResult<IEnumerable<NotificationToken>>> GetNotificationTokens(string userId)
        {
            logger.LogDebug("UsersController -> GetNotificationTokens: getting notification tokens for user");
            var notificationTokens = await usersRepository.GetNotificationTokens(userId);
            return Ok(notificationTokens);
        }
    }
}
