using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Zenturiq.Models;
using System.Data.Entity;

namespace Zenturiq.Controllers
{
    public class EstudianteController : Controller
    {
        private Conexion db = new Conexion();

        // GET: Estudiante/Perfil
        public ActionResult Perfil(string searchString)
        {
            var estudiantes = from e in db.Estudiante
                              select e;

            if (!String.IsNullOrEmpty(searchString))
            {
                estudiantes = estudiantes.Where(s => s.Nombres.Contains(searchString)
                                       || s.ApellidoPaterno.Contains(searchString)
                                       || s.ApellidoMaterno.Contains(searchString)
                                       || s.CodigoEstudiante.Contains(searchString));
            }

            // Mapear los datos a EstudianteViewModel
            var model = estudiantes.Select(e => new EstudianteViewModel
            {
                IDEstudiante = e.IDEstudiante,
                CodigoEstudiante = e.CodigoEstudiante,
                ApellidoPaterno = e.ApellidoPaterno,
                ApellidoMaterno = e.ApellidoMaterno,
                Nombres = e.Nombres,
                Sexo = e.Sexo
            }).ToList();

            ViewBag.CurrentFilter = searchString;

            return View(model);
        }

        // GET: Estudiante/Detalles/5
        public ActionResult Detalles(int id)
        {
            var estudiante = db.Estudiante.Find(id);
            if (estudiante == null)
            {
                return HttpNotFound();
            }

            var model = new EstudianteViewModel
            {
                // Incluimos IDEstudiante para uso interno, no lo mostraremos en la vista
                IDEstudiante = estudiante.IDEstudiante,
                CodigoEstudiante = estudiante.CodigoEstudiante,
                ApellidoPaterno = estudiante.ApellidoPaterno,
                ApellidoMaterno = estudiante.ApellidoMaterno,
                Nombres = estudiante.Nombres,
                TipoDocumento = estudiante.TipoDocumento,
                NumeroDocumento = estudiante.NumeroDocumento,
                ValidadoConReniec = estudiante.ValidadoConReniec,
                Sexo = estudiante.Sexo,
                FechaNacimiento = estudiante.FechaNacimiento
            };

            ViewBag.ActiveTab = "Perfil";
            return View(model);
        }

        public ActionResult Notas(int id)
        {
            var estudiante = db.Estudiante.Find(id);
            if (estudiante == null)
            {
                return HttpNotFound();
            }

            // Obtener todas las notas del estudiante con los datos relacionados
            var notas = db.Notas
                .Include(n => n.CriteriosEvaluacion)
                .Include(n => n.CriteriosEvaluacion.Curso)
                .Where(n => n.IDEstudiante == id)
                .ToList();

            // Agrupar por Curso
            var notasPorCurso = notas
                .GroupBy(n => n.CriteriosEvaluacion.Curso)
                .Select(g => new NotasCursoViewModel
                {
                    CursoNombre = g.Key.Nombre,
                    NotasPorCriterio = g.GroupBy(n => n.CriteriosEvaluacion)
                        .Select(gc => new NotaPorCriterioViewModel
                        {
                            CursoNombre = g.Key.Nombre,
                            CriterioNombre = gc.Key.NombreCriterio,
                            NotaBimestre1 = gc.Where(n => n.NumeroBimestre == 1).Select(n => n.Nota).FirstOrDefault(),
                            NotaBimestre2 = gc.Where(n => n.NumeroBimestre == 2).Select(n => n.Nota).FirstOrDefault(),
                            NotaBimestre3 = gc.Where(n => n.NumeroBimestre == 3).Select(n => n.Nota).FirstOrDefault(),
                            NotaBimestre4 = gc.Where(n => n.NumeroBimestre == 4).Select(n => n.Nota).FirstOrDefault(),
                            NotaFinalCriterio = CalculateFinalGrade(gc.Select(n => n.Nota).ToList())
                        }).ToList(),
                    NotaFinalCurso = "" // Calcularemos esto después
                }).ToList();

            // Calcular la nota final por Curso
            foreach (var curso in notasPorCurso)
            {
                var finalGrades = curso.NotasPorCriterio.Select(n => n.NotaFinalCriterio).ToList();
                curso.NotaFinalCurso = CalculateFinalGrade(finalGrades);
            }

            ViewBag.Estudiante = estudiante; // Pasar la información del estudiante a la vista
            ViewBag.IDEstudiante = id; // Asegurarnos de pasar el ID del estudiante
            ViewBag.ActiveTab = "Notas";

            return View(notasPorCurso);
        }


        // Función para calcular la nota final
        private string CalculateFinalGrade(List<string> grades)
        {
            // Remover notas nulas o vacías
            var validGrades = grades
                .Where(g => !string.IsNullOrEmpty(g))
                .Select(g => g.Trim().ToUpper()) // Normalizar las notas
                .ToList();

            if (validGrades.Count == 0)
                return ""; // No hay notas para calcular

            // Mapear notas a valores numéricos
            var gradeValues = validGrades.Select(g => GradeToValue(g)).ToList();

            var average = gradeValues.Average();

            var finalGrade = ValueToGrade(average);
            return finalGrade;
        }

        // Mapear nota a valor numérico
        private int GradeToValue(string grade)
        {
            if (string.IsNullOrEmpty(grade))
                return 0; // Nota no definida

            grade = grade.Trim().ToUpper(); // Normalizar la nota

            switch (grade)
            {
                case "AD":
                    return 4;
                case "A":
                    return 3;
                case "B":
                    return 2;
                case "C":
                    return 1;
                default:
                    return 0; // Nota no definida
            }
        }

        // Mapear valor numérico a nota
        private string ValueToGrade(double value)
        {
            if (value >= 3.5)
                return "AD";
            else if (value >= 2.5)
                return "A";
            else if (value >= 1.5)
                return "B";
            else
                return "C";
        }

        // GET: Estudiante/Extracurricular/5
        public ActionResult Extracurricular(int id)
        {
            var estudiante = db.Estudiante.Find(id);
            if (estudiante == null)
            {
                return HttpNotFound();
            }

            // Obtener las actividades extracurriculares del estudiante, agrupadas por Nombre
            var actividadesEstudiante = db.ExtracurricularEstudiante
                .Include(e => e.Extracurricular)
                .Where(e => e.IDEstudiante == id)
                .GroupBy(e => e.Extracurricular.Nombre)
                .Select(g => new ActividadExtracurricularViewModel
                {
                    Nombre = g.Key,
                    Criterios = g.Select(e => e.Extracurricular.Criterio).Distinct().ToList()
                })
                .ToList();

            var model = new ExtracurricularViewModel
            {
                IDEstudiante = id,
                Actividades = actividadesEstudiante
            };

            ViewBag.Estudiante = estudiante;
            ViewBag.ActiveTab = "Extracurricular";
            return View(model);
        }

        // GET: Estudiante/AgregarExtracurricular/5
        public ActionResult AgregarExtracurricular(int id)
        {
            var estudiante = db.Estudiante.Find(id);
            if (estudiante == null)
            {
                return HttpNotFound();
            }

            // Obtener la lista de actividades extracurriculares disponibles
            var actividadesDisponibles = ObtenerActividadesDisponibles();

            var model = new SeleccionarExtracurricularViewModel
            {
                IDEstudiante = id,
                ListaActividades = actividadesDisponibles
            };

            return PartialView("_AgregarExtracurricular", model);
        }

        // POST: Estudiante/AgregarExtracurricular
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AgregarExtracurricular(SeleccionarExtracurricularViewModel model)
        {
            if (ModelState.IsValid)
            {
                // Obtener todas las actividades con el nombre seleccionado
                var actividades = db.Extracurricular
                    .Where(e => e.Nombre == model.NombreActividad)
                    .ToList();

                foreach (var actividad in actividades)
                {
                    // Verificar si la actividad ya está asignada al estudiante
                    var existe = db.ExtracurricularEstudiante
                        .Any(e => e.IDEstudiante == model.IDEstudiante && e.IDExtracurricular == actividad.IDExtracurricular);

                    if (!existe)
                    {
                        var nuevaAsignacion = new ExtracurricularEstudiante
                        {
                            IDEstudiante = model.IDEstudiante,
                            IDExtracurricular = actividad.IDExtracurricular
                        };

                        db.ExtracurricularEstudiante.Add(nuevaAsignacion);
                    }
                }
                db.SaveChanges();

                return RedirectToAction("Extracurricular", new { id = model.IDEstudiante });
            }

            // Si el modelo no es válido, recargar la lista de actividades
            model.ListaActividades = ObtenerActividadesDisponibles();
            return PartialView("_AgregarExtracurricular", model);
        }

        private List<ActividadExtracurricularViewModel> ObtenerActividadesDisponibles()
        {
            return db.Extracurricular
                .Where(e => e.Estado == "Activo")
                .GroupBy(e => e.Nombre)
                .Select(g => new ActividadExtracurricularViewModel
                {
                    Nombre = g.Key,
                    IDExtracurricular = g.Min(e => e.IDExtracurricular)
                })
                .ToList();
        }

        // POST: Estudiante/EliminarExtracurricular
        [HttpPost]
        public ActionResult EliminarExtracurricular(int idEstudiante, string nombreActividad)
        {
            var asignaciones = db.ExtracurricularEstudiante
                .Include(e => e.Extracurricular)
                .Where(e => e.IDEstudiante == idEstudiante && e.Extracurricular.Nombre == nombreActividad)
                .ToList();

            if (asignaciones.Any())
            {
                db.ExtracurricularEstudiante.RemoveRange(asignaciones);
                db.SaveChanges();
            }

            return RedirectToAction("Extracurricular", new { id = idEstudiante });
        }


        // GET: Estudiante/RealizarTest/5
        public ActionResult RealizarTest(int id)
        {
            var estudiante = db.Estudiante.Find(id);
            if (estudiante == null)
            {
                return HttpNotFound();
            }

            // Cargar todas las preguntas ordenadas por número
            var preguntas = db.PreguntasTest
                .OrderBy(p => p.NumeroPregunta)
                .Select(p => new PreguntaTestViewModel
                {
                    IDPregunta = p.IDPregunta,
                    NumeroPregunta = p.NumeroPregunta,
                    TextoPregunta = p.TextoPregunta,
                    TipoPregunta = p.TipoPregunta,
                    CodigoArea = p.CodigoArea,
                    Respuesta = -1 // Valor por defecto, no respondida
                })
                .ToList();

            var model = new TestViewModel
            {
                IDEstudiante = id,
                Preguntas = preguntas
            };

            ViewBag.Estudiante = estudiante;
            ViewBag.ActiveTab = "RealizarTest";

            return View(model);
        }


        // POST: Estudiante/RealizarTest
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult RealizarTest(TestViewModel model)
        {
            if (ModelState.IsValid)
            {
                int idEstudiante = model.IDEstudiante;

                // Eliminar respuestas anteriores del estudiante
                var respuestasExistentes = db.RespuestasTest.Where(r => r.IDEstudiante == idEstudiante).ToList();
                if (respuestasExistentes.Any())
                {
                    db.RespuestasTest.RemoveRange(respuestasExistentes);
                    db.SaveChanges();
                }

                // Guardar las nuevas respuestas
                foreach (var pregunta in model.Preguntas)
                {
                    // Verificar si la pregunta fue respondida
                    if (pregunta.Respuesta != -1)
                    {
                        var respuesta = new RespuestasTest
                        {
                            IDEstudiante = idEstudiante,
                            IDPregunta = pregunta.IDPregunta,
                            Respuesta = pregunta.Respuesta == 1 // Conversión de int a bool
                        };
                        db.RespuestasTest.Add(respuesta);
                    }
                    // Si deseas manejar las no respondidas, puedes agregar lógica aquí
                }
                db.SaveChanges();

                // Redirigir a la vista de resultados o a una página de confirmación
                return RedirectToAction("ResultadosTest", new { id = idEstudiante });
            }

            // Si el modelo no es válido, recargar las preguntas
            var preguntas = db.PreguntasTest
                .OrderBy(p => p.NumeroPregunta)
                .Select(p => new PreguntaTestViewModel
                {
                    IDPregunta = p.IDPregunta,
                    NumeroPregunta = p.NumeroPregunta,
                    TextoPregunta = p.TextoPregunta,
                    TipoPregunta = p.TipoPregunta,
                    CodigoArea = p.CodigoArea,
                    Respuesta = -1
                })
                .ToList();

            model.Preguntas = preguntas;

            ViewBag.Estudiante = db.Estudiante.Find(model.IDEstudiante);
            ViewBag.ActiveTab = "RealizarTest";

            return View(model);
        }

        // GET: Estudiante/ResultadosTest/5
        public ActionResult ResultadosTest(int id)
        {
            var estudiante = db.Estudiante.Find(id);
            if (estudiante == null)
            {
                return HttpNotFound();
            }

            // Obtener todas las respuestas del estudiante
            var respuestas = db.RespuestasTest
                .Include(r => r.PreguntasTest)
                .Where(r => r.IDEstudiante == id)
                .ToList();

            if (respuestas == null || !respuestas.Any())
            {
                // Si el estudiante no ha realizado el test, mostrar un mensaje
                ViewBag.Mensaje = "No has completado el test aún.";
                return View();
            }

            // Inicializar diccionarios para contar respuestas afirmativas por área y tipo de pregunta
            var resultadosInteres = new Dictionary<string, int>();
            var resultadosAptitud = new Dictionary<string, int>();

            // Orden de las áreas según Chaside
            var ordenChaside = new List<string> { "C", "H", "A", "S", "I", "D", "E" };

            // Obtener todas las áreas
            var areas = db.Areas.ToList();

            // Inicializar los diccionarios con las áreas
            foreach (var area in areas)
            {
                resultadosInteres[area.CodigoArea] = 0;
                resultadosAptitud[area.CodigoArea] = 0;
            }

            // Procesar las respuestas
            foreach (var respuesta in respuestas)
            {
                if (respuesta.Respuesta) // Respuesta afirmativa
                {
                    var codigoArea = respuesta.PreguntasTest.CodigoArea;
                    var tipoPregunta = respuesta.PreguntasTest.TipoPregunta;

                    if (tipoPregunta == "Interés")
                    {
                        resultadosInteres[codigoArea]++;
                    }
                    else if (tipoPregunta == "Aptitud")
                    {
                        resultadosAptitud[codigoArea]++;
                    }
                }
            }

            // Encontrar el puntaje máximo para Interés y Aptitud
            int maxInteres = resultadosInteres.Values.Max();
            int maxAptitud = resultadosAptitud.Values.Max();

            // Obtener las áreas con el puntaje máximo en Interés, ordenadas según Chaside
            var topAreasInteres = resultadosInteres
                .Where(r => r.Value == maxInteres)
                .OrderBy(r => ordenChaside.IndexOf(r.Key))
                .ToList();

            // Obtener las áreas con el puntaje máximo en Aptitud, ordenadas según Chaside
            var topAreasAptitud = resultadosAptitud
                .Where(r => r.Value == maxAptitud)
                .OrderBy(r => ordenChaside.IndexOf(r.Key))
                .ToList();

            // Crear el ViewModel para pasar a la vista
            var model = new ResultadosTestViewModel
            {
                IDEstudiante = id,
                Estudiante = estudiante,
                ResultadosInteres = resultadosInteres,
                ResultadosAptitud = resultadosAptitud,
                TopAreasInteres = topAreasInteres,
                TopAreasAptitud = topAreasAptitud,
                Areas = areas.ToDictionary(a => a.CodigoArea)
            };

            ViewBag.Estudiante = estudiante;
            ViewBag.ActiveTab = "ResultadosTest";

            return View(model);
        }


    }
}
