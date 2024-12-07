import 'package:flutter/material.dart';
import 'Test.dart';
import 'ResultadosTest.dart';

class TestVocacionalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Vocacional'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Realizar Test',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Card(
              child: ListTile(
                title: Text('Realizar Test'),
                subtitle: Text(
                    'Texto explicativo acerca del test vocacional. Instrucciones breves y detalles importantes.'),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Navegar a la vista del Test
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestScreen(),
                      ),
                    );
                  },
                  child: Text('Entrar'),
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              child: ListTile(
                title: Text('Ver Resultados'),
                subtitle: Text(
                    'Texto explicativo acerca de la consulta de los resultados del test vocacional.'),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Navegar a la vista de Resultados
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultadosTestScreen(
                          respuestas: {
                            'equipo': 8,
                            'aire_libre': 7,
                            'decisiones': 9,
                            'tecnologia': 10,
                            'creatividad': 6,
                            'matematicas': 8,
                          },
                        ),
                      ),
                    );
                  },
                  child: Text('Entrar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
