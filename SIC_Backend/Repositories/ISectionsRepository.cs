using SIC_Backend.Data.Models;

namespace SIC_Backend.Repositories
{
    public interface ISectionsRepository
    {
        public Task<Section> GetSectionByIdAsync(int id);
        public Task<IEnumerable<Section>> GetSectionsByUserIdAsync(string userId);
        public Task<IEnumerable<Section>> GetSectionsByPlaceIdAsync(int placeId);
        public Task<Section> CreateSectionAsync(CreateSectionModel model);
        public Task<Section> UpdateSectionAsync(int id, UpdateSectionModel model);
        public Task DeleteSectionAsync(int id);
    }
}
