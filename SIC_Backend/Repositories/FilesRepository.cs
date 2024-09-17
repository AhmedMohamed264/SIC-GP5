using SIC_Backend.Data;
using SIC_Backend.Data.Models;

namespace SIC_Backend.Repositories
{
    public class FilesRepository(ApplicationDbContext dbContext) : IFilesRepository
    {
        public async Task AddImages(int cameraId, List<string> images)
        {
            foreach (var image in images)
            {
                dbContext.Images.Add(new SicImage { Url = image, TakenAt = DateTime.Now, CameraId = cameraId });
                await dbContext.SaveChangesAsync();
            }
        }
    }
}
