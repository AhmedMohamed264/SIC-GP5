using Microsoft.EntityFrameworkCore;
using SIC_Backend.Data;
using SIC_Backend.Data.DTOs;
using SIC_Backend.Data.Models;

namespace SIC_Backend.Repositories
{
    public class PlacesRepository(ApplicationDbContext dbContext) : IPlacesRepository
    {
        public PlaceDTO GetPlaceById(int id)
        {
            var place = dbContext.Places.Where(p => p.Id == id)
                .Include(p => p.Sections)
                .ThenInclude(s => s.Devices)
                .Select(PlaceDTO.FromPlace)
                .First();

            return place;
        }

        public IEnumerable<PlaceDTO> GetPlacesByUserId(string userId)
        {
            return dbContext.Places.Where(p => p.UserId == userId)
                .Include(p => p.Sections)
                .ThenInclude(s => s.Devices)
                .Select(PlaceDTO.FromPlace)
                .ToList();
        }

        public async Task CreatePlaceAsync(CreatePlaceModel model)
        {
            var place = Place.FromCreateModel(model);

            dbContext.Places.Add(place);

            await dbContext.SaveChangesAsync();
        }

        public async Task UpdatePlaceAsync(int id, UpdatePlaceModel model)
        {
            var place = await dbContext.Places.FindAsync(id);

            if (place == null)
            {
                //throw new NotFoundException("Place not found");
            }

            place!.Name = model.Name;

            await dbContext.SaveChangesAsync();
        }

        public async Task DeletePlaceAsync(int id)
        {
            var place = await dbContext.Places.FindAsync(id);

            if (place == null)
            {
                //throw new NotFoundException("Place not found");
            }

            dbContext.Places.Remove(place!);
            await dbContext.SaveChangesAsync();
        }
    }
}
