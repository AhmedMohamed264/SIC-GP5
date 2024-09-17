using CloudinaryDotNet.Actions;
using Microsoft.AspNetCore.Mvc;
using CloudinaryDotNet;
using SIC_Backend.Services;
using SIC_Backend.Repositories;

namespace Universe_Backend.Controllers;

[ApiController]
[Route("[controller]")]
public class FilesController(ILogger<FilesController> logger, IFilesService filesService, IFilesRepository filesRepository) : ControllerBase
{
    [HttpPost("{cameraId}Images/Upload")]
    public async Task<ActionResult<List<string>>> UploadImage(int cameraId, [FromForm] List<IFormFile> images)
    {
        logger.LogDebug($"FilesController -> UploadImage: Got {images.Count} images.");
        var imageUrls = await filesService.UploadImage(images);
        await filesRepository.AddImages(cameraId, imageUrls);
        return Ok(imageUrls);
    }

    //[HttpPost("Videos/Upload")]
    //public async Task<ActionResult<string>> UploadVideo([FromForm] List<IFormFile> videos)
    //{
    //    logger.LogDebug("");
    //    var videoUrl = await filesService.UploadVideo(videos);
    //    return Ok(videoUrl);
    //}

    //[HttpPost("Audios/Upload")]
    //public async Task<ActionResult<string>> UploadAudio([FromForm] List<IFormFile> audios)
    //{
    //    logger.LogDebug("");
    //    var audioUrl = await filesService.UploadAudio(audios);
    //    return Ok(audioUrl);
    //}
}
