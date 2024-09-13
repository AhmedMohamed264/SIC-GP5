using Microsoft.AspNetCore.Mvc;
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
        public async Task<ActionResult<Place>> GetPlaceById(int id)
        {
            logger.LogDebug("PlacesController -> GetPlaceById: getting place by id");
            var place = await placesRepository.GetPlaceByIdAsync(id);

            return Ok(place);
        }

        [HttpGet]
        [Route("user/{userId}")]
        public async Task<ActionResult<IEnumerable<Place>>> GetPlacesByUserId(string userId)
        {
            logger.LogDebug("PlacesController -> GetPlacesByUserId: getting places by user id");
            var places = await placesRepository.GetPlacesByUserIdAsync(userId);

            return Ok(places);
        }

        [HttpPost]
        public async Task<ActionResult<Place>> CreatePlace([FromBody] CreatePlaceModel model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            logger.LogDebug("PlacesController -> CreatePlace: creating place");
            var place = await placesRepository.CreatePlaceAsync(model);

            return Ok(place);
        }

        [HttpPut]
        [Route("{id}")]
        public async Task<ActionResult<Place>> UpdatePlace(int id, [FromBody] UpdatePlaceModel model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            logger.LogDebug("PlacesController -> UpdatePlace: updating place");
            var place = await placesRepository.UpdatePlaceAsync(id, model);

            return Ok(place);
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
