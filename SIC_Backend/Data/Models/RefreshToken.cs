﻿using System.ComponentModel.DataAnnotations;

namespace SIC_Backend.Data.Models;

public class RefreshToken
{
    [Key]
    public int Id { get; set; }
    public required string Token { get; set; }
    public required string UserId { get; set; }
    public DateTime ExpiryDate { get; set; }
    public bool IsRevoked { get; set; }
}