using SIC_Backend.Data.Models;

namespace SIC_Backend.Data.DTOs
{
    public class UserDTO
    {
        public required string Id { get; set; }
        public required string FirstName { get; set; }
        public required string LastName { get; set; }
        public required string UserName { get; set; }
        public required string Email { get; set; }

        public required IEnumerable<PlaceDTO> Places { get; set; }

        public static UserDTO FromUser(User user)
        {
            return new UserDTO
            {
                Id = user.Id,
                FirstName = user.FirstName,
                LastName = user.LastName,
                UserName = user.UserName!,
                Email = user.Email!,
                Places = user.Places.Select(PlaceDTO.FromPlace),
            };
        }
    }
}
