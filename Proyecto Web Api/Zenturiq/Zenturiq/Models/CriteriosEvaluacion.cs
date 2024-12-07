namespace Zenturiq.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("CriteriosEvaluacion")]
    public partial class CriteriosEvaluacion
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CriteriosEvaluacion()
        {
            Notas = new HashSet<Notas>();
        }

        [Key]
        public int IDCriterio { get; set; }

        [Required]
        public string NombreCriterio { get; set; }

        public int IDCurso { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Notas> Notas { get; set; }

        public virtual Curso Curso { get; set; }
    }
}
