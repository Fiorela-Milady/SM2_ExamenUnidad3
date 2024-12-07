namespace Zenturiq.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Estudiante")]
    public partial class Estudiante
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Estudiante()
        {
            ExtracurricularEstudiante = new HashSet<ExtracurricularEstudiante>();
            Notas = new HashSet<Notas>();
            RegistroExtracurricular = new HashSet<RegistroExtracurricular>();
            RespuestasTest = new HashSet<RespuestasTest>();
            ResultadosTest = new HashSet<ResultadosTest>();
        }

        [Key]
        public int IDEstudiante { get; set; }

        [Required]
        [StringLength(20)]
        public string TipoDocumento { get; set; }

        [Required]
        [StringLength(20)]
        public string NumeroDocumento { get; set; }

        [Required]
        [StringLength(20)]
        public string ValidadoConReniec { get; set; }

        [Required]
        [StringLength(20)]
        public string CodigoEstudiante { get; set; }

        [Required]
        [StringLength(50)]
        public string ApellidoPaterno { get; set; }

        [Required]
        [StringLength(50)]
        public string ApellidoMaterno { get; set; }

        [Required]
        [StringLength(100)]
        public string Nombres { get; set; }

        [Required]
        [StringLength(10)]
        public string Sexo { get; set; }

        [Column(TypeName = "date")]
        public DateTime FechaNacimiento { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ExtracurricularEstudiante> ExtracurricularEstudiante { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Notas> Notas { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RegistroExtracurricular> RegistroExtracurricular { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RespuestasTest> RespuestasTest { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ResultadosTest> ResultadosTest { get; set; }
    }
}
