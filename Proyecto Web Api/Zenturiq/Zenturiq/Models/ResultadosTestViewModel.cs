using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Zenturiq.Models;

namespace Zenturiq.Models
{


    public class ResultadosTestViewModel
    {
        public int IDEstudiante { get; set; }
        public Estudiante Estudiante { get; set; }
        public Dictionary<string, int> ResultadosInteres { get; set; }
        public Dictionary<string, int> ResultadosAptitud { get; set; }
        public List<KeyValuePair<string, int>> TopAreasInteres { get; set; }
        public List<KeyValuePair<string, int>> TopAreasAptitud { get; set; }
        public Dictionary<string, Areas> Areas { get; set; } // Mapeo de CodigoArea a objeto Areas
    }


}