namespace SIC_Backend.Repositories
{
    public interface IFilesRepository
    {
        public Task AddImages(int cameraId, List<string> images);
    }
}
