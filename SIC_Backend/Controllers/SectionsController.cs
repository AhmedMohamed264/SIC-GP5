using Microsoft.AspNetCore.Mvc;
using SIC_Backend.Data.DTOs;
using SIC_Backend.Data.Models;
using SIC_Backend.Repositories;

namespace SIC_Backend.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SectionsController(ISectionsRepository sectionsRepository, ILogger<SectionsController> logger) : ControllerBase
    {
        [HttpGet("{id}")]
        public ActionResult<SectionDTO> GetSectionById(int id)
        {
            logger.LogDebug("SectionsController -> GetSectionById: getting section by id");
            var section = sectionsRepository.GetSectionById(id);

            return Ok(section);
        }

        [HttpGet("User/{userId}")]
        public ActionResult<IEnumerable<SectionDTO>> GetSectionsByUserId(string userId)
        {
            logger.LogDebug("SectionsController -> GetSectionsByUserId: getting sections by user id");
            var sections = sectionsRepository.GetSectionsByUserId(userId);

            return Ok(sections);
        }

        [HttpGet("Place/{placeId}")]
        public ActionResult<IEnumerable<SectionDTO>> GetSectionsByPlaceId(int placeId)
        {
            logger.LogDebug("SectionsController -> GetSectionsByPlaceId: getting sections by place id");
            var sections = sectionsRepository.GetSectionsByPlaceId(placeId);

            return Ok(sections);
        }

        [HttpPost]
        public async Task<IActionResult> CreateSection([FromBody] CreateSectionModel model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            logger.LogDebug("SectionsController -> CreateSection: creating section");
            await sectionsRepository.CreateSectionAsync(model);

            return NoContent();
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateSection(int id, [FromBody] UpdateSectionModel model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            logger.LogDebug("SectionsController -> UpdateSection: updating section");
            await sectionsRepository.UpdateSectionAsync(id, model);

            return NoContent();
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
