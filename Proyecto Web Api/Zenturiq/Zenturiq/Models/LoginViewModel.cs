using System.ComponentModel.DataAnnotations;

namespace Zenturiq.Models
{
    public class LoginViewModel
    {
        [Required(ErrorMessage = "El correo electrónico es obligatorio.")]
        [EmailAddress(ErrorMessage = "Formato de correo inválido.")]
        [StringLength(100)]
        public string CorreoElectronico { get; set; }

        [Required(ErrorMessage = "La contraseña es obligatoria.")]
        [DataType(DataType.Password)]
        [StringLength(255, MinimumLength = 3, ErrorMessage = "La contraseña debe tener al menos 5 caracteres.")]
        public string Contraseña { get; set; }
    }
}
