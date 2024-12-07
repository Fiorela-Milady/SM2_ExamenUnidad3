using System;
using System.Linq;
using System.Web.Mvc;
using System.Web.Security;
using Zenturiq.Models;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;



namespace Zenturiq.Controllers
{
    public class LoginController : Controller
    {
        private Conexion db = new Conexion();

        // GET: Login
        public ActionResult Index()
        {
            return View(new LoginViewModel());
        }

        // POST: Login/Index
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Index(LoginViewModel model)
        {
            if (ModelState.IsValid)
            {
                // Encriptar la contraseña ingresada
                string contraseñaEncriptada = CrearHash(model.Contraseña);

                // Verificar credenciales
                var user = db.Usuario.FirstOrDefault(u => u.CorreoElectronico == model.CorreoElectronico && u.Contraseña == contraseñaEncriptada);
                if (user != null)
                {
                    // Crear la cookie de autenticación
                    FormsAuthentication.SetAuthCookie(user.IDUsuario.ToString(), false);
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ViewBag.Error = "Correo electrónico o contraseña incorrectos.";
                }
            }
            return View(model);
        }

        // Método para encriptar la contraseña
        private string CrearHash(string contraseña)
        {
            using (var sha256 = SHA256.Create())
            {
                byte[] bytes = Encoding.UTF8.GetBytes(contraseña);
                byte[] hash = sha256.ComputeHash(bytes);
                return Convert.ToBase64String(hash);
            }
        }

        // GET: Login/Logout
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index");
        }

        // GET: Login/RecuperarCuenta
        public ActionResult RecuperarCuenta()
        {
            return View();
        }

        // POST: Login/RecuperarCuenta
        [HttpPost]
        public ActionResult RecuperarCuenta(string correoElectronico)
        {
            var usuario = db.Usuario.FirstOrDefault(u => u.CorreoElectronico == correoElectronico);
            if (usuario != null)
            {
                // Generar código aleatorio
                var codigoRecuperacion = GenerarCodigo();

                // Guardar el código y la fecha de expiración en la base de datos
                usuario.CodigoRecuperacion = codigoRecuperacion;
                usuario.FechaExpiracionCodigo = DateTime.Now.AddMinutes(15); // El código expira en 15 minutos
                db.SaveChanges();

                // Enviar el correo electrónico
                bool correoEnviado = EnviarCorreo(correoElectronico, "Recuperación de cuenta", $"Tu código de recuperación es: {codigoRecuperacion}");

                if (correoEnviado)
                {
                    ViewBag.Message = "Correo enviado exitosamente. Revisa tu bandeja de entrada.";
                    return RedirectToAction("VerificarCodigoRecuperacion", new { correo = correoElectronico });
                }
                else
                {
                    ViewBag.Error = "Error al enviar el correo. Intenta nuevamente.";
                }
            }
            else
            {
                ViewBag.Error = "El correo electrónico no está registrado.";
            }
            return View();
        }

        // GET: Login/VerificarCodigoRecuperacion
        public ActionResult VerificarCodigoRecuperacion(string correo)
        {
            ViewBag.CorreoElectronico = correo;
            return View();
        }

        // POST: Login/VerificarCodigoRecuperacion
        [HttpPost]
        public ActionResult VerificarCodigoRecuperacion(string correoElectronico, string codigo, string nuevaContraseña, string confirmarContraseña)
        {
            var usuario = db.Usuario.FirstOrDefault(u => u.CorreoElectronico == correoElectronico);
            if (usuario != null)
            {
                if (usuario.CodigoRecuperacion == codigo && usuario.FechaExpiracionCodigo > DateTime.Now)
                {
                    if (nuevaContraseña == confirmarContraseña)
                    {
                        // Actualizar la contraseña
                        usuario.Contraseña = CrearHash(nuevaContraseña);
                        usuario.CodigoRecuperacion = null;
                        usuario.FechaExpiracionCodigo = null;
                        db.SaveChanges();

                        ViewBag.Message = "Contraseña actualizada exitosamente.";
                        return RedirectToAction("Index");
                    }
                    else
                    {
                        ViewBag.Error = "Las contraseñas no coinciden.";
                    }
                }
                else
                {
                    ViewBag.Error = "El código es incorrecto o ha expirado.";
                }
            }
            else
            {
                ViewBag.Error = "El correo electrónico no está registrado.";
            }
            ViewBag.CorreoElectronico = correoElectronico;
            return View();
        }

        // GET: Login/Registrarse
        public ActionResult Registrarse()
        {
            return View(new Usuario());
        }

        // POST: Login/Registrarse
        [HttpPost]
        public ActionResult Registrarse(Usuario usuario)
        {
            if (ModelState.IsValid)
            {
                // Verificar si el correo ya está registrado
                var existeUsuario = db.Usuario.Any(u => u.CorreoElectronico == usuario.CorreoElectronico);
                if (!existeUsuario)
                {
                    // Generar código de verificación
                    var codigoVerificacion = GenerarCodigo();

                    // Asignar el código y fecha de expiración
                    usuario.CodigoVerificacion = codigoVerificacion;
                    usuario.FechaExpiracionCodigo = DateTime.Now.AddMinutes(30); // El código expira en 30 minutos

                    // Encriptar la contraseña
                    usuario.Contraseña = CrearHash(usuario.Contraseña);

                    // Guardar el usuario en la base de datos
                    db.Usuario.Add(usuario);
                    db.SaveChanges();

                    // Enviar correo de verificación
                    bool correoEnviado = EnviarCorreo(usuario.CorreoElectronico, "Verificación de cuenta", $"Tu código de verificación es: {codigoVerificacion}");

                    if (correoEnviado)
                    {
                        ViewBag.Message = "Registro exitoso. Revisa tu correo para verificar tu cuenta.";
                        return RedirectToAction("VerificarCuenta", new { correo = usuario.CorreoElectronico });
                    }
                    else
                    {
                        ViewBag.Error = "Error al enviar el correo de verificación.";
                    }
                }
                else
                {
                    ViewBag.Error = "El correo electrónico ya está registrado.";
                }
            }
            return View(usuario);
        }

        // GET: Login/VerificarCuenta
        public ActionResult VerificarCuenta(string correo)
        {
            ViewBag.CorreoElectronico = correo;
            return View();
        }

        // POST: Login/VerificarCuenta
        [HttpPost]
        public ActionResult VerificarCuenta(string correoElectronico, string codigo)
        {
            var usuario = db.Usuario.FirstOrDefault(u => u.CorreoElectronico == correoElectronico);
            if (usuario != null)
            {
                if (usuario.CodigoVerificacion == codigo && usuario.FechaExpiracionCodigo > DateTime.Now)
                {
                    // Verificar la cuenta
                    usuario.CodigoVerificacion = null;
                    usuario.FechaExpiracionCodigo = null;
                    db.SaveChanges();

                    ViewBag.Message = "Cuenta verificada exitosamente. Ahora puedes iniciar sesión.";
                    return RedirectToAction("Index");
                }
                else
                {
                    ViewBag.Error = "El código es incorrecto o ha expirado.";
                }
            }
            else
            {
                ViewBag.Error = "El correo electrónico no está registrado.";
            }
            ViewBag.CorreoElectronico = correoElectronico;
            return View();
        }

        // Método para generar un código aleatorio de 6 dígitos
        private string GenerarCodigo()
        {
            Random random = new Random();
            return random.Next(100000, 999999).ToString();
        }

        

        // Método para enviar correos electrónicos
        private bool EnviarCorreo(string correoDestino, string asunto, string cuerpo)
        {
            try
            {
                var mensaje = new MailMessage();
                mensaje.To.Add(new MailAddress(correoDestino));
                mensaje.Subject = asunto;
                mensaje.Body = cuerpo;
                mensaje.IsBodyHtml = false;

                using (var smtp = new SmtpClient())
                {
                    smtp.Send(mensaje);
                }
                return true;
            }
            catch (Exception ex)
            {
                // Log de error (opcional)
                Console.WriteLine(ex.Message);
                return false;
            }
        }
    }
}
