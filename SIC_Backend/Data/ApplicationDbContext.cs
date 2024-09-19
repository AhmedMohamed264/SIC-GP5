using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using SIC_Backend.Data.Models;

namespace SIC_Backend.Data
{
    public class ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : IdentityDbContext<User>(options)
    {
        public DbSet<RefreshToken> RefreshTokens { get; set; }
        public DbSet<Place> Places { get; set; }
        public DbSet<Section> Sections { get; set; }
        public DbSet<Device> Devices { get; set; }
        public DbSet<NotificationToken> NotificationTokens { get; set; }
        public DbSet<SicImage> Images { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);
            builder.Entity<User>().ToTable("users").HasMany(u => u.Devices).WithOne(d => d.User);
            builder.Entity<User>().ToTable("users").HasMany(u => u.Places).WithOne(p => p.User);
            builder.Entity<User>().ToTable("users").HasMany(u => u.Sections).WithOne(s => s.User);
            builder.Entity<Place>().ToTable("places").HasMany(p => p.Devices).WithOne(d => d.Place);
            builder.Entity<Place>().ToTable("places").HasMany(p => p.Sections).WithOne(s => s.Place);
            builder.Entity<Section>().ToTable("sections").HasMany(s => s.Devices).WithOne(d => d.Section);
            builder.Entity<Device>().ToTable("devices").Property(d => d.DeviceType).HasConversion<string>();
            builder.Entity<NotificationToken>().ToTable("notification_tokens").HasOne(nt => nt.User).WithMany(u => u.NotificationTokens);
            builder.Entity<SicImage>().ToTable("images");
        }
    }
}
