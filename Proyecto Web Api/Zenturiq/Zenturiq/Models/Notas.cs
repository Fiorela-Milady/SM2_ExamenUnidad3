namespace Zenturiq.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Notas
    {
        [Key]
        public int IDNota { get; set; }

        public int IDEstudiante { get; set; }

        public int NumeroBimestre { get; set; }

        public int IDCriterio { get; set; }

        [Required]
        [StringLength(2)]
        public string Nota { get; set; }

        public virtual CriteriosEvaluacion CriteriosEvaluacion { get; set; }

        public virtual Estudiante Estudiante { get; set; }
    }
}
