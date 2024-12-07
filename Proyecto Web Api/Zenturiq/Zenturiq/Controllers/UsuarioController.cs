using System;
using System.Web.Mvc;
using Zenturiq.Models;

namespace Zenturiq.Controllers
{
    [Authorize]
    public class UsuarioController : Controller
    {
        private Conexion db = new Conexion();

        // GET: Usuario/EditarPerfil
        public ActionResult EditarPerfil()
        {
            int userId = int.Parse(User.Identity.Name);
            var usuario = db.Usuario.Find(userId);
            if (usuario == null)
            {
                return HttpNotFound();
            }

            var model = new EditarPerfilViewModel
            {
                IDUsuario = usuario.IDUsuario,
                Nombre = usuario.Nombre,
                Apellido = usuario.Apellido,
                CorreoElectronico = usuario.CorreoElectronico,
                Telefono = usuario.Telefono
            };

            return View(model);
        }

        // POST: Usuario/EditarPerfil
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditarPerfil(EditarPerfilViewModel model)
        {
            if (ModelState.IsValid)
            {
                var usuarioExistente = db.Usuario.Find(model.IDUsuario);
                if (usuarioExistente == null)
                {
                    ViewBag.Error = "Usuario no encontrado.";
                    return View(model);
                }

                usuarioExistente.Nombre = model.Nombre;
                usuarioExistente.Apellido = model.Apellido;
                usuarioExistente.Telefono = model.Telefono;

                db.SaveChanges();

                Session["NombreCompleto"] = usuarioExistente.Nombre + " " + usuarioExistente.Apellido;

                ViewBag.Message = "Perfil actualizado correctamente.";

                return View(model);
            }
            else
            {
                ViewBag.Error = "Hubo un error en los datos ingresados.";
                return View(model);
            }
        }



        // GET: Usuario/CambiarContraseña
        public ActionResult CambiarContraseña()
        {
            return View();
        }

        // POST: Usuario/CambiarContraseña
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CambiarContraseña(string contraseñaActual, string nuevaContraseña, string confirmarContraseña)
        {
            int userId = int.Parse(User.Identity.Name);
            var usuario = db.Usuario.Find(userId);

            if (usuario != null)
            {
                string contraseñaActualHash = CrearHash(contraseñaActual);
                if (usuario.Contraseña == contraseñaActualHash)
                {
                    if (nuevaContraseña == confirmarContraseña)
                    {
                        usuario.Contraseña = CrearHash(nuevaContraseña);
                        db.SaveChanges();
                        ViewBag.Message = "Contraseña actualizada correctamente.";
                    }
                    else
                    {
                        ViewBag.Error = "Las nuevas contraseñas no coinciden.";
                    }
                }
                else
                {
                    ViewBag.Error = "La contraseña actual es incorrecta.";
                }
            }
            else
            {
                ViewBag.Error = "Usuario no encontrado.";
            }
            return View();
        }

        // Método para encriptar la contraseña (igual que en LoginController)
        private string CrearHash(string contraseña)
        {
            using (var sha256 = System.Security.Cryptography.SHA256.Create())
            {
                byte[] bytes = System.Text.Encoding.UTF8.GetBytes(contraseña);
                byte[] hash = sha256.ComputeHash(bytes);
                return Convert.ToBase64String(hash);
            }
        }
    }
}
