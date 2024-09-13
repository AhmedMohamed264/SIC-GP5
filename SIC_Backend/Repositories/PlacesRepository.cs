using Microsoft.EntityFrameworkCore;
using SIC_Backend.Data;
using SIC_Backend.Data.Models;

namespace SIC_Backend.Repositories
{
    public class PlacesRepository(ApplicationDbContext dbContext) : IPlacesRepository
    {
        public async Task<Place> GetPlaceByIdAsync(int id)
        {
            var place = await dbContext.Places.FindAsync(id);

            if (place == null)
            {
                //throw new NotFoundException("Place not found");
            }

            return place!;
        }

        public async Task<IEnumerable<Place>> GetPlacesByUserIdAsync(string userId)
        {
            return await dbContext.Places.Where(p => p.UserId == userId).ToListAsync();
        }

        public async Task<Place> CreatePlaceAsync(CreatePlaceModel model)
        {
            var place = Place.FromCreateModel(model);

            dbContext.Places.Add(place);
            await dbContext.SaveChangesAsync();

            return place;
        }

        public async Task<Place> UpdatePlaceAsync(int id, UpdatePlaceModel model)
        {
            var place = await dbContext.Places.FindAsync(id);

            if (place == null)
            {
                //throw new NotFoundException("Place not found");
            }

            place!.Name = model.Name;

            await dbContext.SaveChangesAsync();

            return place;
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
