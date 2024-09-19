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
        [Route("publish/int/{pin}")]
        public async Task<ActionResult> PublishInt(int pin, int data, [FromServices] IHubContext<DevicesDataHub> hubContext)
        {
            await hubContext.Clients.Group(pin.ToString()).SendAsync("ReceiveData", data);
            return Ok();
        }

        [HttpPost]
        [Route("publish/float/{pin}")]
        public async Task<ActionResult> PublishFloat(int pin, float data, [FromServices] IHubContext<DevicesDataHub> hubContext)
        {
            await hubContext.Clients.Group(pin.ToString()).SendAsync("ReceiveData", data);
            return Ok();
        }

        [HttpPost]
        [Route("publish/string/{pin}")]
        public async Task<ActionResult> PublishString(int pin, string data, [FromServices] IHubContext<DevicesDataHub> hubContext)
        {
            await hubContext.Clients.Group(pin.ToString()).SendAsync("ReceiveData", data);
            return Ok();
        }

        [HttpPost]
        [Route("publish/boolean/{pin}")]
        public async Task<ActionResult> PublishBoolean(int pin, bool data, [FromServices] IHubContext<DevicesDataHub> hubContext)
        {
            await hubContext.Clients.Group(pin.ToString()).SendAsync("ReceiveData", data);
            return Ok();
        }

        [HttpPost]
        [Route("TTS/{text}")]
        public async Task<ActionResult> TTS(string text, [FromServices] IHubContext<DevicesDataHub> hubContext)
        {
            await hubContext.Clients.Group("TTS").SendAsync("ToSpeach", text);
            return Ok();
        }
    }
}
