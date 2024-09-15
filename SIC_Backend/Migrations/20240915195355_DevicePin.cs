using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SIC_Backend.Migrations
{
    /// <inheritdoc />
    public partial class DevicePin : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Pin",
                table: "devices",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Pin",
                table: "devices");
        }
    }
}
