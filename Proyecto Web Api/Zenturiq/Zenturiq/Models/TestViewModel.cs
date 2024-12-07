using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Zenturiq.Models
{
    public class TestViewModel
    {
        public int IDEstudiante { get; set; }
        public List<PreguntaTestViewModel> Preguntas { get; set; }
    }

}