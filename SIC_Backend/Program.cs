using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Http.Features;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using SIC_Backend.Data;
using SIC_Backend.Data.Models;
using SIC_Backend.Hubs;
using SIC_Backend.Repositories;
using SIC_Backend.Services;
using System.Net;
using System.Net.WebSockets;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddCors(
    options =>
    {
        options.AddDefaultPolicy(
            builder =>
            {
                builder.WithOrigins("http://ahmedafifi-lt:5283")
                    .AllowAnyHeader()
                    .AllowAnyMethod();
            });
    });

builder.WebHost.ConfigureKestrel(serverOptions =>
{
    serverOptions.Limits.MaxRequestBodySize = long.MaxValue;
});

builder.Services.Configure<FormOptions>(options => options.MultipartBodyLengthLimit = 50 * 1024 * 1024);

builder.Services.AddDbContext<ApplicationDbContext>(cfg =>
    cfg.UseMySql(builder.Configuration["ConnectionStrings:DefaultConnection"], new MySqlServerVersion(new Version(8, 0, 39))));

var fcmService = new NotificationService.Services.FcmService();
var notificationService = new NotificationService.NotificationService(fcmService, fcmService, fcmService);

builder.Services.AddIdentity<User, IdentityRole>(options => options.User.RequireUniqueEmail = true)
.AddEntityFrameworkStores<ApplicationDbContext>()
.AddDefaultTokenProviders();

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = builder.Configuration["Jwt:Issuer"],
        ValidAudience = builder.Configuration["Jwt:Audience"],
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"]!))
    };
});

builder.Services.AddSingleton(notificationService);
builder.Services.AddScoped<TokenService>();
builder.Services.AddScoped<IFilesService, FilesService>();
builder.Services.AddScoped<IUsersRepository, UsersRepository>();
builder.Services.AddScoped<IPlacesRepository, PlacesRepository>();
builder.Services.AddScoped<ISectionsRepository, SectionsRepository>();
builder.Services.AddScoped<IDevicesRepository, DevicesRepository>();
builder.Services.AddScoped<IFilesRepository, FilesRepository>();

builder.Services.AddSignalR();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseWebSockets();

var webSocketHandler = new WebSocketHandler();

app.Map("/LiveFeed", async context =>
{
    if (context.WebSockets.IsWebSocketRequest)
    {
        Console.WriteLine("Websocket connection.");
        await webSocketHandler.HandleWebSocketAsync(context);
    }
    else
    {
        Console.WriteLine("Not a websocket connection");
        context.Response.StatusCode = 400;
    }
});

app.UseHttpsRedirection();

app.MapHub<DevicesDataHub>("/DevicesDataHub");

app.UseAuthorization();

app.MapControllers();

app.Run();
