namespace SIC_Backend.Services
{
    public interface IFilesService
    {
        public Task<string> UploadImage(IFormFile image);
        public Task<List<string>> UploadVideo(List<IFormFile> videos);
        public Task<List<string>> UploadAudio(List<IFormFile> audios);
    }
}
