using Microsoft.AspNetCore.Mvc;
using SIC_Backend.Data.Models;
using SIC_Backend.Repositories;

namespace SIC_Backend.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SectionsController(ISectionsRepository sectionsRepository, ILogger<SectionsController> logger) : ControllerBase
    {
        [HttpGet("{id}")]
        public async Task<IActionResult> GetSectionById(int id)
        {
            logger.LogDebug("SectionsController -> GetSectionById: getting section by id");
            var section = await sectionsRepository.GetSectionByIdAsync(id);

            return Ok(section);
        }

        [HttpGet("User/{userId}")]
        public async Task<IActionResult> GetSectionsByUserId(string userId)
        {
            logger.LogDebug("SectionsController -> GetSectionsByUserId: getting sections by user id");
            var sections = await sectionsRepository.GetSectionsByUserIdAsync(userId);

            return Ok(sections);
        }

        [HttpGet("Place/{placeId}")]
        public async Task<IActionResult> GetSectionsByPlaceId(int placeId)
        {
            logger.LogDebug("SectionsController -> GetSectionsByPlaceId: getting sections by place id");
            var sections = await sectionsRepository.GetSectionsByPlaceIdAsync(placeId);

            return Ok(sections);
        }

        [HttpPost]
        public async Task<IActionResult> CreateSection([FromBody] CreateSectionModel model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            logger.LogDebug("SectionsController -> CreateSection: creating section");
            var section = await sectionsRepository.CreateSectionAsync(model);

            return Ok(section);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateSection(int id, [FromBody] UpdateSectionModel model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            logger.LogDebug("SectionsController -> UpdateSection: updating section");
            var section = await sectionsRepository.UpdateSectionAsync(id, model);

            return Ok(section);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSection(int id)
        {
            logger.LogDebug("SectionsController -> DeleteSection: deleting section");
            await sectionsRepository.DeleteSectionAsync(id);

            return Ok();
        }
    }
}
