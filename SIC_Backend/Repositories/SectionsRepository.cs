using Microsoft.EntityFrameworkCore;
using SIC_Backend.Data;
using SIC_Backend.Data.DTOs;
using SIC_Backend.Data.Models;

namespace SIC_Backend.Repositories
{
    public class SectionsRepository(ApplicationDbContext dbContext) : ISectionsRepository
    {
        public SectionDTO GetSectionById(int id)
        {
            var section = dbContext.Sections.Where(s => s.Id == id)
                .Include(s => s.Devices)
                .Select(SectionDTO.FromSection)
                .First();

            return section;
        }

        public IEnumerable<SectionDTO> GetSectionsByUserId(string userId)
        {
            return dbContext.Sections.Where(s => s.UserId == userId)
                .Include(s => s.Devices)
                .Select(SectionDTO.FromSection)
                .ToList();
        }

        public IEnumerable<SectionDTO> GetSectionsByPlaceId(int placeId)
        {
            return dbContext.Sections.Where(s => s.PlaceId == placeId)
                .Include(s => s.Devices)
                .Select(SectionDTO.FromSection)
                .ToList();
        }

        public async Task CreateSectionAsync(CreateSectionModel model)
        {
            var section = Section.FromCreateModel(model);

            dbContext.Sections.Add(section);

            await dbContext.SaveChangesAsync();
        }

        public async Task UpdateSectionAsync(int id, UpdateSectionModel model)
        {
            var section = await dbContext.Sections.FindAsync(id);

            if (section == null)
            {
                //throw new NotFoundException("Section not found");
            }

            section!.Name = model.Name;
            section.PlaceId = model.PlaceId;

            await dbContext.SaveChangesAsync();
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
