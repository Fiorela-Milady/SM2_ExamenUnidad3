using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Zenturiq.Models
{
    public class PreguntaTestViewModel
    {
        public int IDPregunta { get; set; }
        public int NumeroPregunta { get; set; }
        public string TextoPregunta { get; set; }
        public string TipoPregunta { get; set; }
        public string CodigoArea { get; set; }
        public int Respuesta { get; set; } // 1 para "Sí", 0 para "No", -1 para no respondida
    }

}