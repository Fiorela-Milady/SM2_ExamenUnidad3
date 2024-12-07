using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Zenturiq.Models
{
    public class SeleccionarExtracurricularViewModel
    {
        public int IDEstudiante { get; set; }

        [Required(ErrorMessage = "Seleccione una actividad extracurricular.")]
        public string NombreActividad { get; set; }

        public List<ActividadExtracurricularViewModel> ListaActividades { get; set; }
    }

}
