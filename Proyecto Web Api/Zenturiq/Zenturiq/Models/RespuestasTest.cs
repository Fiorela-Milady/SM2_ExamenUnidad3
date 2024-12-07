namespace Zenturiq.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("RespuestasTest")]
    public partial class RespuestasTest
    {
        [Key]
        public int IDRespuesta { get; set; }

        public int IDEstudiante { get; set; }

        public int IDPregunta { get; set; }

        public bool Respuesta { get; set; }

        public virtual Estudiante Estudiante { get; set; }

        public virtual PreguntasTest PreguntasTest { get; set; }
    }
}
