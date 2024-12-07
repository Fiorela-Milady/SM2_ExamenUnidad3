namespace Zenturiq.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("PreguntasTest")]
    public partial class PreguntasTest
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public PreguntasTest()
        {
            RespuestasTest = new HashSet<RespuestasTest>();
        }

        [Key]
        public int IDPregunta { get; set; }

        public int NumeroPregunta { get; set; }

        [Required]
        public string TextoPregunta { get; set; }

        [Required]
        [StringLength(10)]
        public string TipoPregunta { get; set; }

        [Required]
        [StringLength(1)]
        public string CodigoArea { get; set; }

        public virtual Areas Areas { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RespuestasTest> RespuestasTest { get; set; }
    }
}
