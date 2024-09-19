using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SIC_Backend.Migrations
{
    /// <inheritdoc />
    public partial class DeviceTypeInDeviceDataTypeOut : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "DataType",
                table: "devices",
                newName: "DeviceType");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "DeviceType",
                table: "devices",
                newName: "DataType");
        }
    }
}
