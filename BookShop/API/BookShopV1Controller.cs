using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BookShop.Models;
using BookShop.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;

namespace BookShop.API
{
    [Route("api/[controller]")]
    [ApiController]
    public class BookShopV1Controller : ControllerBase
    {
        IBookShopRepo _bookShop;

        public BookShopV1Controller(IBookShopRepo bookshop)
        {
            _bookShop = bookshop;
        }

        [HttpGet("Categories")]
        public async Task<IActionResult> Categories(string title)
        {
            try
            {
                List<Category> catList = await _bookShop.getCategories(title);
                return Ok(catList);
            }
            catch (Exception ex)
            { return Ok(ex.Message); }
        }

        [HttpGet("Authors")]
        [SwaggerResponse(200)]
        //[Authorize]
        public async Task<IActionResult> Authors()
        {
            try
            {
                var autList = await _bookShop.getAuthors();
                return Ok(autList);
            }
            catch (Exception ex)
            {
                return Ok(ex.Message);
            }
        }
        //https://www.yogihosting.com/aspnet-core-consume-api/#create
        //https://www.tutorialsteacher.com/webapi/consume-web-api-get-method-in-aspnet-mvc
        [HttpGet("Books")]
        public async Task<IActionResult> Book()
        {
            try
            {
                var bookList = await _bookShop.getBooks();
                return Ok(bookList);
            }
            catch (Exception ex)
            {
                return Ok(ex.Message);
            }
        }

        //POST - CREATE
        [HttpPost("Book")]
        public async Task<IActionResult> Create(Book book)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var bookResult = await _bookShop.createBook(book);
                }
                return Ok(book);
            }
            catch (Exception ex)
            {
                return Ok(ex.Message);
            }
        }
    }
}
