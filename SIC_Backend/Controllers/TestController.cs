using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using SIC_Backend.Hubs;
using System.Security.Claims;

namespace SIC_Backend.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TestController : ControllerBase
    {
        [HttpGet]
        [Route("")]
        public IActionResult Get()
        {
            return Ok("Hello World");
        }

        [HttpPost]
        [Route("publish/{pin}")]
        public async Task<ActionResult> PublishData(int pin, int data, [FromServices] IHubContext<DevicesDataHub> hubContext)
        {
            await hubContext.Clients.Group(pin.ToString()).SendAsync("ReceiveData", data);
            return Ok();
        }
    }
}
