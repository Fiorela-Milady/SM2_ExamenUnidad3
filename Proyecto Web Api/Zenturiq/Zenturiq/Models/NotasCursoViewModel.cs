using System.Collections.Generic;

namespace Zenturiq.Models
{
    public class NotasCursoViewModel
    {
        public string CursoNombre { get; set; }
        public List<NotaPorCriterioViewModel> NotasPorCriterio { get; set; }
        public string NotaFinalCurso { get; set; } // Calculado a partir de los criterios
    }
}
