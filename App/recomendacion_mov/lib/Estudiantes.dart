import 'package:flutter/material.dart';
import 'PerfilEstudiante.dart';
import 'TestVocacional.dart';
import 'services/auth_service.dart'; // Asegúrate de importar el servicio

class StudentsListScreen extends StatefulWidget {
  @override
  _StudentsListScreenState createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  List<Map<String, String>> students = [];
  String searchQuery = '';
  bool isLoading = true; // Variable para gestionar el estado de carga

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  // Método para cargar los estudiantes desde la API
  Future<void> _loadStudents() async {
    try {
      final List<Map<String, dynamic>> fetchedStudents =
          await AuthService.getStudents();

      // Convertir explícitamente la lista de Map<String, dynamic> a List<Map<String, String>>
      // final List<Map<String, String>> convertedStudents =
      //     fetchedStudents.map((student) {
      //   return {
      //     'apellido':
      //         student['apellido']?.toString() ?? '', // Convertir a String
      //     'nombre': student['nombre']?.toString() ?? '', // Convertir a String
      //     'grado': student['grado']?.toString() ?? '', // Convertir a String
      //     'tutor': student['tutor']?.toString() ?? '', // Convertir a String
      //     'id': student['id']?.toString() ?? '', // Asegurarse de incluir el ID
      //     'numeroDocumento': student['numeroDocumento']?.toString() ??
      //         '', // Número de documento
      //     'sexo': student['sexo']?.toString() ?? '', // Sexo del estudiante
      //     'tipoDocumento':
      //         student['tipoDocumento']?.toString() ?? '', // Tipo de documento
      //     'fechaNacimiento': student['fechaNacimiento']?.toString() ??
      //         '', // Fecha de nacimiento
      //   };
      // }).toList();

      final List<Map<String, String>> convertedStudents =
          fetchedStudents.map((student) {
        return {
          'apellido': student['apellido']?.toString() ?? '', // Apellido Paterno
          'nombre':
              student['nombre']?.toString() ?? '', // Nombre del estudiante
          'id': student['id']?.toString() ?? '', // ID del estudiante
          'codigoEstudiante': student['codigoEstudiante']?.toString() ??
              '', // Código del estudiante
          'numeroDocumento': student['numeroDocumento']?.toString() ??
              '', // Número de documento
          'sexo': student['sexo']?.toString() ?? '', // Sexo del estudiante
          'tipoDocumento':
              student['tipoDocumento']?.toString() ?? '', // Tipo de documento
          'fechaNacimiento': student['fechaNacimiento']?.toString() ??
              '', // Fecha de nacimiento
        };
      }).toList();

      setState(() {
        students = convertedStudents;
        isLoading = false; // Actualizar el estado de carga
      });
    } catch (e) {
      print('Error al cargar los estudiantes: $e');
      setState(() {
        isLoading =
            false; // Asegúrate de actualizar isLoading en caso de error también
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredStudents = students
        .where((student) =>
            student['nombre']!
                .toLowerCase()
                .contains(searchQuery.toLowerCase()) ||
            student['apellido']!
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Estudiantes'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Buscar estudiante',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            // Mostrar un indicador de carga mientras se obtiene la lista de estudiantes
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: filteredStudents.length,
                      itemBuilder: (context, index) {
                        final student = filteredStudents[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${student['apellido']} ${student['nombre']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Grado: ${student['grado']}\nTutor: ${student['tutor']}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TestVocacionalScreen(),
                                          ),
                                        );
                                      },
                                      child: Text('Test Vocacional'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PerfilEstudianteScreen(
                                              nombre: student['nombre']!,
                                              apellido: student['apellido']!,
                                              codigoEstudiante: student[
                                                  'id']!, // Aquí usas el 'id' del estudiante
                                              numeroDocumento:
                                                  student['numeroDocumento']!,
                                              sexo: student['sexo']!,
                                              tipoDocumento:
                                                  student['tipoDocumento']!,
                                              fechaNacimiento:
                                                  student['fechaNacimiento']!,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text('Perfil'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
