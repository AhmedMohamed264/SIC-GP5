using SIC_Backend.Data.Models;

namespace SIC_Backend.Repositories
{
    public interface IPlacesRepository
    {
        public Task<Place> GetPlaceByIdAsync(int id);
        public Task<IEnumerable<Place>> GetPlacesByUserIdAsync(string userId);
        public Task<Place> CreatePlaceAsync(CreatePlaceModel model);
        public Task<Place> UpdatePlaceAsync(int id, UpdatePlaceModel model);
        public Task DeletePlaceAsync(int id);
    }
}
