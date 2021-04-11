using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace BookShop.Models
{
    public partial class BookShop_DBContext : DbContext
    {
        public BookShop_DBContext()
        {
        }

        public BookShop_DBContext(DbContextOptions<BookShop_DBContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Author> Authors { get; set; }
        public virtual DbSet<Book> Books { get; set; }
        public virtual DbSet<BooksDetail> BooksDetails { get; set; }
        public virtual DbSet<Category> Categories { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=BookShop_DB;Integrated Security=True;MultipleActiveResultSets=True");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "SQL_Latin1_General_CP1_CI_AS");

            modelBuilder.Entity<Author>(entity =>
            {
                entity.HasKey(e => e.AId);

                entity.ToTable("Author");

                entity.Property(e => e.AId).HasColumnName("aID");

                entity.Property(e => e.FirstName)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("firstName");

                entity.Property(e => e.LastName)
                    .HasMaxLength(100)
                    .HasColumnName("lastName");
            });

            modelBuilder.Entity<Book>(entity =>
            {
                entity.HasKey(e => new { e.BId, e.IsbnNo });

                entity.HasIndex(e => e.IsbnNo, "UQ__Books__AA06B8B0CC83F6F6")
                    .IsUnique();

                entity.Property(e => e.BId)
                    .ValueGeneratedOnAdd()
                    .HasColumnName("bID");

                entity.Property(e => e.IsbnNo)
                    .HasMaxLength(50)
                    .HasColumnName("isbnNo");

                entity.Property(e => e.CId).HasColumnName("cID");

                entity.Property(e => e.Published)
                    .HasColumnType("datetime")
                    .HasColumnName("published");

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasMaxLength(255)
                    .HasColumnName("title");
            });

            modelBuilder.Entity<BooksDetail>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("Books_Details");

                entity.Property(e => e.AId).HasColumnName("aID");

                entity.Property(e => e.BId).HasColumnName("bID");
            });

            modelBuilder.Entity<Category>(entity =>
            {
                entity.HasKey(e => new { e.CId, e.Title });

                entity.ToTable("Category");

                entity.Property(e => e.CId)
                    .ValueGeneratedOnAdd()
                    .HasColumnName("cID");

                entity.Property(e => e.Title)
                    .HasMaxLength(150)
                    .HasColumnName("title");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
