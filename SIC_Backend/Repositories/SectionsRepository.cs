using Microsoft.EntityFrameworkCore;
using SIC_Backend.Data;
using SIC_Backend.Data.Models;

namespace SIC_Backend.Repositories
{
    public class SectionsRepository(ApplicationDbContext dbContext) : ISectionsRepository
    {
        public async Task<Section> GetSectionByIdAsync(int id)
        {
            var section = await dbContext.Sections.FindAsync(id);

            if (section == null)
            {
                //throw new NotFoundException("Section not found");
            }

            return section!;
        }

        public async Task<IEnumerable<Section>> GetSectionsByUserIdAsync(string userId)
        {
            return await dbContext.Sections.Where(s => s.UserId == userId).ToListAsync();
        }

        public async Task<IEnumerable<Section>> GetSectionsByPlaceIdAsync(int placeId)
        {
            return await dbContext.Sections.Where(s => s.PlaceId == placeId).ToListAsync();
        }

        public async Task<Section> CreateSectionAsync(CreateSectionModel model)
        {
            var section = Section.FromCreateModel(model);

            dbContext.Sections.Add(section);
            await dbContext.SaveChangesAsync();

            return section;
        }

        public async Task<Section> UpdateSectionAsync(int id, UpdateSectionModel model)
        {
            var section = await dbContext.Sections.FindAsync(id);

            if (section == null)
            {
                //throw new NotFoundException("Section not found");
            }

            section!.Name = model.Name;
            section.PlaceId = model.PlaceId;

            await dbContext.SaveChangesAsync();

            return section!;
        }

        public async Task DeleteSectionAsync(int id)
        {
            var section = await dbContext.Sections.FindAsync(id);

            if (section == null)
            {
                //throw new NotFoundException("Section not found");
            }

            dbContext.Sections.Remove(section!);
            await dbContext.SaveChangesAsync();
        }
    }
}
