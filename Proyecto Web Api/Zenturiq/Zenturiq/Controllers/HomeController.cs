using System.Web.Mvc;

namespace Zenturiq.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        // GET: Home/Index
        public ActionResult Index()
        {
            ViewBag.Title = "Inicio";
            return View();
        }
    }
}
