using Microsoft.AspNetCore.Mvc;

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
    }
}
