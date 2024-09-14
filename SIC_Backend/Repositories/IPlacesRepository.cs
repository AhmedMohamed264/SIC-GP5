using SIC_Backend.Data.DTOs;
using SIC_Backend.Data.Models;

namespace SIC_Backend.Repositories
{
    public interface IPlacesRepository
    {
        public PlaceDTO GetPlaceById(int id);
        public IEnumerable<PlaceDTO> GetPlacesByUserId(string userId);
        public Task CreatePlaceAsync(CreatePlaceModel model);
        public Task UpdatePlaceAsync(int id, UpdatePlaceModel model);
        public Task DeletePlaceAsync(int id);
    }
}
