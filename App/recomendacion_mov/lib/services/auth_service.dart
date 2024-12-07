import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl =
      'http://127.0.0.1:8000'; // Cambia la URL según sea necesario

  // Método para realizar el inicio de sesión
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'CorreoElectronico': email, // Usar 'CorreoElectronico' como clave
          'Contraseña': password, // Usar 'Contraseña' como clave
        }),
      );

      // Revisar la respuesta completa para depuración
      print("Response status: ${response.statusCode}");
      print(
          "Response body: ${response.body}"); // Imprime el cuerpo completo de la respuesta

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Asegurarse de que los campos esperados estén presentes
        if (data.containsKey("IDUsuario")) {
          // Guardar los datos en SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt("user_id", data["IDUsuario"]);
          await prefs.setString("nombre", data["Nombre"]);
          await prefs.setString("apellido", data["Apellido"]);
          await prefs.setString("email", data["CorreoElectronico"]);

          // Verificar si los datos se han guardado correctamente
          print("User ID: ${prefs.getInt('user_id')}");
          print("User Name: ${prefs.getString('nombre')}");
          print("User Email: ${prefs.getString('email')}");

          return true;
        } else {
          print("Error: No se encontró IDUsuario en la respuesta");
          return false;
        }
      } else {
        print('Error en login: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error en login: $e');
      return false;
    }
  }

  // Método para obtener la lista de estudiantes
  static Future<List<Map<String, dynamic>>> getStudents() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/estudiantes'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print(
            'Datos obtenidos: $data'); // Imprimir la respuesta para depuración

        return data.map((student) {
          return {
            'id': student['IDEstudiante'] ?? '', // Agregar el ID del estudiante
            'apellido': (student['ApellidoPaterno'] ?? '') +
                ' ' +
                (student['ApellidoMaterno'] ??
                    ''), // Concatenar ambos apellidos
            'nombre': student['Nombres'] ?? '', // Nombre del estudiante
            'codigoEstudiante':
                student['CodigoEstudiante'] ?? '', // Código Estudiante
            'numeroDocumento':
                student['NumeroDocumento'] ?? '', // Número de documento
            'sexo': student['Sexo'] ?? '', // Sexo
            'tipoDocumento':
                student['TipoDocumento'] ?? '', // Tipo de documento
            'fechaNacimiento':
                student['FechaNacimiento'] ?? '', // Fecha de nacimiento
          };
        }).toList();
      } else {
        throw Exception('Error al cargar los estudiantes');
      }
    } catch (e) {
      print('Error al obtener estudiantes: $e');
      return [];
    }
  }
}
