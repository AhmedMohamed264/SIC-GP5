using Microsoft.AspNetCore.Mvc;
using SIC_Backend.Data.DTOs;
using SIC_Backend.Data.Models;
using SIC_Backend.Repositories;

namespace SIC_Backend.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DevicesController(IDevicesRepository devicesRepository, ILogger<DevicesController> logger) : ControllerBase
    {
        [HttpGet("{id}")]
        public async Task<ActionResult<DeviceDTO>> GetDeviceById(int id)
        {
            logger.LogDebug("DevicesController -> getDeviceById: getting device by id");
            var device = await devicesRepository.GetDeviceByIdAsync(id);

            return Ok(device);
        }

        [HttpGet("User/{userId}")]
        public ActionResult<IEnumerable<DeviceDTO>> GetDevicesByUserId(string userId)
        {
            logger.LogDebug("DevicesController -> getDevicesByUserId: getting devices by user id");
            var devices = devicesRepository.GetDevicesByUserId(userId);

            return Ok(devices);
        }

        [HttpGet("Place/{placeId}")]
        public ActionResult<IEnumerable<DeviceDTO>> GetDevicesByPlaceId(int placeId)
        {
            logger.LogDebug("DevicesController -> getDevicesByPlaceId: getting devices by place id");
            var devices = devicesRepository.GetDevicesByPlaceId(placeId);

            return Ok(devices);
        }

        [HttpGet("Section/{sectionId}")]
        public IActionResult GetDevicesBySectionId(int sectionId)
        {
            logger.LogDebug("DevicesController -> getDevicesBySectionId: getting devices by section id");
            var devices = devicesRepository.GetDevicesBySectionId(sectionId);

            return Ok(devices);
        }

        [HttpPost]
        public async Task<IActionResult> CreateDevice([FromBody] CreateDeviceModel model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            logger.LogDebug("DevicesController -> createDevice: creating device");
            await devicesRepository.CreateDeviceAsync(model);

            return NoContent();
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateDevice(int id, [FromBody] UpdateDeviceModel model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            logger.LogDebug("DevicesController -> updateDevice: updating device");
            await devicesRepository.UpdateDeviceAsync(id, model);

            return NoContent();
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
