namespace Zenturiq.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Extracurricular")]
    public partial class Extracurricular
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Extracurricular()
        {
            ExtracurricularEstudiante = new HashSet<ExtracurricularEstudiante>();
            RegistroExtracurricular = new HashSet<RegistroExtracurricular>();
        }

        [Key]
        public int IDExtracurricular { get; set; }

        [Required]
        [StringLength(100)]
        public string Nombre { get; set; }

        [Required]
        [StringLength(100)]
        public string Criterio { get; set; }

        [Required]
        [StringLength(10)]
        public string Estado { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ExtracurricularEstudiante> ExtracurricularEstudiante { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RegistroExtracurricular> RegistroExtracurricular { get; set; }
    }
}
