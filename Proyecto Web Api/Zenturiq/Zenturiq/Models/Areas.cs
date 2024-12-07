namespace Zenturiq.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Areas
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Areas()
        {
            PreguntasTest = new HashSet<PreguntasTest>();
            ResultadosTest = new HashSet<ResultadosTest>();
        }

        [Key]
        [StringLength(1)]
        public string CodigoArea { get; set; }

        [Required]
        [StringLength(100)]
        public string NombreArea { get; set; }

        public string AtributosInteres { get; set; }

        public string AtributosAptitud { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PreguntasTest> PreguntasTest { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ResultadosTest> ResultadosTest { get; set; }
    }
}
