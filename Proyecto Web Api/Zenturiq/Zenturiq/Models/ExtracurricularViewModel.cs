using System.Collections.Generic;

namespace Zenturiq.Models
{
    public class ExtracurricularViewModel
    {
        public int IDEstudiante { get; set; }
        public List<ActividadExtracurricularViewModel> Actividades { get; set; }
    }

    public class ActividadExtracurricularViewModel
    {
        public int IDExtracurricular { get; set; }
        public string Nombre { get; set; }
        public List<string> Criterios { get; set; }
    }
}
