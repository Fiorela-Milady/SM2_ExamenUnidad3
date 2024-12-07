using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;

namespace Zenturiq.Models
{
    public partial class Conexion : DbContext
    {
        public Conexion()
            : base("name=Conexion")
        {
        }

        public virtual DbSet<Areas> Areas { get; set; }
        public virtual DbSet<CriteriosEvaluacion> CriteriosEvaluacion { get; set; }
        public virtual DbSet<Curso> Curso { get; set; }
        public virtual DbSet<Estudiante> Estudiante { get; set; }
        public virtual DbSet<Extracurricular> Extracurricular { get; set; }
        public virtual DbSet<ExtracurricularEstudiante> ExtracurricularEstudiante { get; set; }
        public virtual DbSet<Notas> Notas { get; set; }
        public virtual DbSet<PreguntasTest> PreguntasTest { get; set; }
        public virtual DbSet<RegistroExtracurricular> RegistroExtracurricular { get; set; }
        public virtual DbSet<RespuestasTest> RespuestasTest { get; set; }
        public virtual DbSet<ResultadosTest> ResultadosTest { get; set; }
        public virtual DbSet<sysdiagrams> sysdiagrams { get; set; }
        public virtual DbSet<Usuario> Usuario { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Areas>()
                .Property(e => e.CodigoArea)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Areas>()
                .HasMany(e => e.PreguntasTest)
                .WithRequired(e => e.Areas)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Areas>()
                .HasMany(e => e.ResultadosTest)
                .WithRequired(e => e.Areas)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<CriteriosEvaluacion>()
                .HasMany(e => e.Notas)
                .WithRequired(e => e.CriteriosEvaluacion)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Curso>()
                .HasMany(e => e.CriteriosEvaluacion)
                .WithRequired(e => e.Curso)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Estudiante>()
                .HasMany(e => e.ExtracurricularEstudiante)
                .WithRequired(e => e.Estudiante)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Estudiante>()
                .HasMany(e => e.Notas)
                .WithRequired(e => e.Estudiante)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Estudiante>()
                .HasMany(e => e.RegistroExtracurricular)
                .WithRequired(e => e.Estudiante)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Estudiante>()
                .HasMany(e => e.RespuestasTest)
                .WithRequired(e => e.Estudiante)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Estudiante>()
                .HasMany(e => e.ResultadosTest)
                .WithRequired(e => e.Estudiante)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Extracurricular>()
                .HasMany(e => e.ExtracurricularEstudiante)
                .WithRequired(e => e.Extracurricular)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Extracurricular>()
                .HasMany(e => e.RegistroExtracurricular)
                .WithRequired(e => e.Extracurricular)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Notas>()
                .Property(e => e.Nota)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<PreguntasTest>()
                .Property(e => e.CodigoArea)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<PreguntasTest>()
                .HasMany(e => e.RespuestasTest)
                .WithRequired(e => e.PreguntasTest)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ResultadosTest>()
                .Property(e => e.CodigoArea)
                .IsFixedLength()
                .IsUnicode(false);
        }
    }
}
