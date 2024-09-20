using CloudinaryDotNet;
using CloudinaryDotNet.Actions;

namespace SIC_Backend.Services
{
    public class FilesService(ILogger<FilesService> logger, IConfiguration configuration) : IFilesService
    {
        public async Task<string> UploadImage(IFormFile image)
        {

            var readStream = image.OpenReadStream();
            logger.LogDebug($"File Details: {image.FileName}, {image.Length}");

            logger.LogDebug(configuration["CLOUDINARY_URL"]);
            var cloudinary = new Cloudinary(configuration["CLOUDINARY_URL"]);
            cloudinary.Api.Secure = true;

            string imageName = Guid.NewGuid().ToString();
            var uploadParams = new ImageUploadParams()
            {
                File = new FileDescription(imageName, readStream),
                PublicId = $"SICHome/Images/{imageName}",
            };

            var uploadResult = await cloudinary.UploadAsync(uploadParams);


            logger.LogDebug($"Cloudinary results: {@uploadResult.StatusCode}");
            
            return uploadResult.SecureUrl.ToString();
        }

        public async Task<List<string>> UploadVideo(List<IFormFile> videos)
        {
            var tasks = new List<Task<VideoUploadResult>>();

            foreach (var video in videos)
            {
                var readStream = video.OpenReadStream();
                logger.LogDebug($"File Details: {video.FileName}, {video.Length}");

                logger.LogDebug(configuration["CLOUDINARY_URL"]);
                var cloudinary = new Cloudinary(configuration["CLOUDINARY_URL"]);
                cloudinary.Api.Secure = true;

                string videoName = Guid.NewGuid().ToString();
                var uploadParams = new VideoUploadParams()
                {
                    File = new FileDescription(videoName, readStream),
                    PublicId = $"SICHome/Videos/{videoName}",
                };
            }

            var uploadResults = await Task.WhenAll(tasks);
            logger.LogDebug($"Cloudinary result: {uploadResults}");

            return uploadResults.Select(result => result.SecureUrl.ToString()).ToList();
        }

        public async Task<List<string>> UploadAudio(List<IFormFile> audios)
        {
            var tasks = new List<Task<VideoUploadResult>>();

            foreach (var audio in audios)
            {
                var readStream = audio.OpenReadStream();
                logger.LogDebug($"File Details: {audio.FileName}, {audio.Length}");

                logger.LogDebug(configuration["CLOUDINARY_URL"]);
                var cloudinary = new Cloudinary(configuration["CLOUDINARY_URL"]);
                cloudinary.Api.Secure = true;

                string audioName = Guid.NewGuid().ToString();
                var uploadParams = new VideoUploadParams()
                {
                    File = new FileDescription(audioName, readStream),
                    PublicId = $"SICHome/Audios/{audioName}",
                };
            }

            var uploadResults = await Task.WhenAll(tasks);
            logger.LogDebug($"Cloudinary result: {uploadResults}");

            return uploadResults.Select(result => result.SecureUrl.ToString()).ToList();
        }
    }
}
