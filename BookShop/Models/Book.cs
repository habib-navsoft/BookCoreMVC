using System;
using System.Collections.Generic;

#nullable disable

namespace BookShop.Models
{
    public partial class Book
    {
        public int BId { get; set; }
        public string Title { get; set; }
        public string IsbnNo { get; set; }
        public DateTime? Published { get; set; }
        public int CId { get; set; }
    }
}
