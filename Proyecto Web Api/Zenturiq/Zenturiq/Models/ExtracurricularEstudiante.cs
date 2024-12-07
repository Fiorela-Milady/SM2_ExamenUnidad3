namespace Zenturiq.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ExtracurricularEstudiante")]
    public partial class ExtracurricularEstudiante
    {
        public int ID { get; set; }

        public int IDEstudiante { get; set; }

        public int IDExtracurricular { get; set; }

        public virtual Estudiante Estudiante { get; set; }

        public virtual Extracurricular Extracurricular { get; set; }
    }
}
