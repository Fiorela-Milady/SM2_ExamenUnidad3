using System.Collections.Generic;

namespace Zenturiq.Models
{
    public class NotaPorCriterioViewModel
    {
        public string CursoNombre { get; set; } // Nombre del Curso
        public string CriterioNombre { get; set; } // Nombre del Criterio

        public string NotaBimestre1 { get; set; } // Nota del Bimestre 1
        public string NotaBimestre2 { get; set; } // Nota del Bimestre 2
        public string NotaBimestre3 { get; set; } // Nota del Bimestre 3
        public string NotaBimestre4 { get; set; } // Nota del Bimestre 4

        public string NotaFinalCriterio { get; set; } // Nota final del Criterio
    }
}
