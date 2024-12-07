namespace Zenturiq.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ResultadosTest")]
    public partial class ResultadosTest
    {
        [Key]
        public int IDResultado { get; set; }

        public int IDEstudiante { get; set; }

        [Required]
        [StringLength(1)]
        public string CodigoArea { get; set; }

        [Required]
        [StringLength(10)]
        public string TipoPregunta { get; set; }

        public int Puntuacion { get; set; }

        public virtual Areas Areas { get; set; }

        public virtual Estudiante Estudiante { get; set; }
    }
}
