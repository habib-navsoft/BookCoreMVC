using BookShop.Models;
using Microsoft.AspNetCore.Components;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

namespace BookShop.Repository
{
    public class BookShopRepo : IBookShopRepo
    {
        private readonly BookShop_DBContext _db;

        public BookShopRepo(BookShop_DBContext db)
        {
            _db = db;
        }

        async Task<List<Author>> IBookShopRepo.getAuthors()
        {
            var autList = await _db.Authors.ToListAsync();
            return autList;
        }

        async Task<List<Book>> IBookShopRepo.getBooks()
        {
            var bookList = await _db.Books.ToListAsync();
            return bookList;
        }

        async Task<List<Category>> IBookShopRepo.getCategories(string title)
        {
            List<Category> catList = null;
            if (string.IsNullOrEmpty(title))
            {
                catList = await _db.Categories.ToListAsync();
            }
            else
            {
                catList = await _db.Categories.Where(c => c.Title.ToLower() == title.ToLower()).ToListAsync();
            }
            return catList;
        }

        async Task<Book> IBookShopRepo.createBook(Book book)
        {
            _db.Books.Add(book);
            await _db.SaveChangesAsync();
            return book;
        }
    }
}
