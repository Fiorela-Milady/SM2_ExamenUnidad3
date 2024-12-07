using System;
using System.ComponentModel.DataAnnotations;

namespace Zenturiq.Models
{
    public class EstudianteViewModel
    {
        public int IDEstudiante { get; set; } // Para uso interno

        [Display(Name = "Código Estudiante")]
        public string CodigoEstudiante { get; set; }

        [Display(Name = "Apellido Paterno")]
        public string ApellidoPaterno { get; set; }

        [Display(Name = "Apellido Materno")]
        public string ApellidoMaterno { get; set; }

        [Display(Name = "Nombres")]
        public string Nombres { get; set; }

        [Display(Name = "Tipo de Documento")]
        public string TipoDocumento { get; set; }

        [Display(Name = "Número de Documento")]
        public string NumeroDocumento { get; set; }

        [Display(Name = "Validado con Reniec")]
        public string ValidadoConReniec { get; set; }

        [Display(Name = "Sexo")]
        public string Sexo { get; set; }

        [Display(Name = "Fecha de Nacimiento")]
        [DataType(DataType.Date)]
        public DateTime FechaNacimiento { get; set; }
    }
}
