using Microsoft.AspNetCore.Mvc;
using SIC_Backend.Data.DTOs;
using SIC_Backend.Data.Models;
using SIC_Backend.Repositories;

namespace SIC_Backend.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PlacesController(IPlacesRepository placesRepository, ILogger<PlacesController> logger) : ControllerBase
    {
        [HttpGet]
        [Route("{id}")]
        public ActionResult<PlaceDTO> GetPlaceById(int id)
        {
            logger.LogDebug("PlacesController -> GetPlaceById: getting place by id");
            var place = placesRepository.GetPlaceById(id);

            return Ok(place);
        }

        [HttpGet]
        [Route("user/{userId}")]
        public ActionResult<IEnumerable<PlaceDTO>> GetPlacesByUserId(string userId)
        {
            logger.LogDebug("PlacesController -> GetPlacesByUserId: getting places by user id");
            var places = placesRepository.GetPlacesByUserId(userId);

            return Ok(places);
        }

        [HttpPost]
        public async Task<ActionResult> CreatePlace([FromBody] CreatePlaceModel model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            logger.LogDebug("PlacesController -> CreatePlace: creating place");
            await placesRepository.CreatePlaceAsync(model);

            return NoContent();
        }

        [HttpPut]
        [Route("{id}")]
        public async Task<ActionResult> UpdatePlace(int id, [FromBody] UpdatePlaceModel model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            logger.LogDebug("PlacesController -> UpdatePlace: updating place");
            await placesRepository.UpdatePlaceAsync(id, model);

            return NoContent();
        }

        [HttpDelete]
        [Route("{id}")]
        public async Task<ActionResult> DeletePlace(int id)
        {
            logger.LogDebug("PlacesController -> DeletePlace: deleting place");
            await placesRepository.DeletePlaceAsync(id);

            return Ok();
        }
    }
}
