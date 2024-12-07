namespace Zenturiq.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Usuario")]
    public partial class Usuario
    {
        [Key]
        public int IDUsuario { get; set; }

        [Required]
        [StringLength(50)]
        public string Nombre { get; set; }

        [Required]
        [StringLength(50)]
        public string Apellido { get; set; }

        [Required]
        [StringLength(100)]
        public string CorreoElectronico { get; set; }

        [Required]
        [StringLength(255)]
        public string Contraseña { get; set; }

        [StringLength(15)]
        public string Telefono { get; set; }

        [StringLength(100)]
        public string CodigoVerificacion { get; set; }

        [StringLength(100)]
        public string CodigoRecuperacion { get; set; }

        public DateTime? FechaExpiracionCodigo { get; set; }
    }
}
