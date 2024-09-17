namespace SIC_Backend.Services
{
    public interface IFilesService
    {
        public Task<List<string>> UploadImage(List<IFormFile> images);
        public Task<List<string>> UploadVideo(List<IFormFile> videos);
        public Task<List<string>> UploadAudio(List<IFormFile> audios);
    }
}
