using BookShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BookShop.Repository
{
    public interface IBookShopRepo
    {
        Task<List<Book>> getBooks();
        Task<List<Category>> getCategories(string title);
        Task<List<Author>> getAuthors();
        Task<Book> createBook(Book book);
    }
}
