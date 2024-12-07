import 'package:flutter/material.dart';
import 'Estudiantes.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Construcción de Software I'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Administrador',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.school, // Icono relacionado con el aprendizaje
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Orientación Vocacional',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil Estudiante'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentsListScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centra horizontalmente
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.dashboard, // Icono principal para el dashboard
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 16),
            Text(
              '¡Bienvenido a Zenturiq',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Aquí encontrarás toda la información importante.',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
