using System.ComponentModel.DataAnnotations;

namespace Zenturiq.Models
{
    public class EditarPerfilViewModel
    {
        public int IDUsuario { get; set; }

        [Required(ErrorMessage = "El nombre es obligatorio.")]
        public string Nombre { get; set; }

        [Required(ErrorMessage = "El apellido es obligatorio.")]
        public string Apellido { get; set; }

        [EmailAddress(ErrorMessage = "Formato de correo inválido.")]
        public string CorreoElectronico { get; set; }

        public string Telefono { get; set; }
    }
}
