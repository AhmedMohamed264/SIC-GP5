using Microsoft.AspNetCore.Mvc;
using SIC_Backend.Data.Models;
using SIC_Backend.Repositories;

namespace SIC_Backend.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DevicesController(IDevicesRepository devicesRepository, ILogger<DevicesController> logger) : ControllerBase
    {
        [HttpGet("{id}")]
        public async Task<IActionResult> GetDeviceById(int id)
        {
            logger.LogDebug("DevicesController -> getDeviceById: getting device by id");
            var device = await devicesRepository.GetDeviceByIdAsync(id);

            return Ok(device);
        }

        [HttpGet("User/{userId}")]
        public async Task<IActionResult> GetDevicesByUserId(string userId)
        {
            logger.LogDebug("DevicesController -> getDevicesByUserId: getting devices by user id");
            var devices = await devicesRepository.GetDevicesByUserIdAsync(userId);

            return Ok(devices);
        }

        [HttpGet("Place/{placeId}")]
        public async Task<IActionResult> GetDevicesByPlaceId(int placeId)
        {
            logger.LogDebug("DevicesController -> getDevicesByPlaceId: getting devices by place id");
            var devices = await devicesRepository.GetDevicesByPlaceIdAsync(placeId);

            return Ok(devices);
        }

        [HttpGet("Section/{sectionId}")]
        public async Task<IActionResult> GetDevicesBySectionId(int sectionId)
        {
            logger.LogDebug("DevicesController -> getDevicesBySectionId: getting devices by section id");
            var devices = await devicesRepository.GetDevicesBySectionIdAsync(sectionId);

            return Ok(devices);
        }

        [HttpPost]
        public async Task<IActionResult> CreateDevice([FromBody] CreateDeviceModel model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            logger.LogDebug("DevicesController -> createDevice: creating device");
            var device = await devicesRepository.CreateDeviceAsync(model);

            return CreatedAtAction(nameof(GetDeviceById), new { id = device.Id }, device);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateDevice(int id, [FromBody] UpdateDeviceModel model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            logger.LogDebug("DevicesController -> updateDevice: updating device");
            var device = await devicesRepository.UpdateDeviceAsync(id, model);

            return Ok(device);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteDevice(int id)
        {
            logger.LogDebug("DevicesController -> deleteDevice: deleting device");
            await devicesRepository.DeleteDeviceAsync(id);

            return NoContent();
        }
    }
}
