using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using BookShop.Models;
using System.Net.Http;
using Newtonsoft.Json;

namespace BookShop.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public async Task<IActionResult> Index()
        {
            List<Book> reservationList = new List<Book>();
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync("https://localhost:44371/api/BookShopV1/Books"))
                {
                    string apiResponse = await response.Content.ReadAsStringAsync();
                    reservationList = JsonConvert.DeserializeObject<List<Book>>(apiResponse);
                }
            }
            return View(reservationList);
        }

        public IActionResult AddBook()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

    }
}
