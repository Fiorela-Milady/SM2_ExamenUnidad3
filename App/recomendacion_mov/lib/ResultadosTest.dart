import 'package:flutter/material.dart';

class ResultadosTestScreen extends StatelessWidget {
  final Map<String, int> respuestas;

  ResultadosTestScreen({required this.respuestas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados del Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resultados del Test Vocacional',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ...respuestas.entries
                .map((entry) => _buildResultado(entry.key, entry.value))
                .toList(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Regresa a la vista del Test
              },
              child: Text('Volver al Test Vocacional'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultado(String criterio, int valor) {
    return ListTile(
      title: Text(criterio),
      subtitle: LinearProgressIndicator(
        value: valor / 10,
        color: Colors.blue,
        backgroundColor: Colors.grey[300],
      ),
      trailing: Text('$valor / 10'),
    );
  }
}
