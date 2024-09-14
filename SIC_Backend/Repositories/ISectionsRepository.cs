using SIC_Backend.Data.DTOs;
using SIC_Backend.Data.Models;

namespace SIC_Backend.Repositories
{
    public interface ISectionsRepository
    {
        public SectionDTO GetSectionById(int id);
        public IEnumerable<SectionDTO> GetSectionsByUserId(string userId);
        public IEnumerable<SectionDTO> GetSectionsByPlaceId(int placeId);
        public Task CreateSectionAsync(CreateSectionModel model);
        public Task UpdateSectionAsync(int id, UpdateSectionModel model);
        public Task DeleteSectionAsync(int id);
    }
}
