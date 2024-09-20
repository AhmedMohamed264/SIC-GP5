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
    [HttpPost("/Images/Upload")]
    public async Task<ActionResult<string>> UploadImage([FromForm] IFormFile img)
    {
        logger.LogDebug($"FilesController -> UploadImage: Got image");
        if (img.Length == 0)
        {
            logger.LogDebug("Empty file");
            return BadRequest("Empty file");
        }
        var imageUrl = await filesService.UploadImage(img);
        await filesRepository.AddImages(0, [imageUrl]);
        return Ok(imageUrl);
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
