import 'package:flutter/material.dart';
import 'ResultadosTest.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final Map<String, int> respuestas = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Vocacional'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildPregunta('¿Te gusta trabajar en equipo?', 'equipo'),
                  _buildPregunta(
                      '¿Prefieres trabajar al aire libre?', 'aire_libre'),
                  _buildPregunta(
                      '¿Te sientes cómodo tomando decisiones importantes?',
                      'decisiones'),
                  _buildPregunta('¿Te interesa la tecnología?', 'tecnologia'),
                  _buildPregunta(
                      '¿Te consideras una persona creativa?', 'creatividad'),
                  _buildPregunta('¿Disfrutas resolver problemas matemáticos?',
                      'matematicas'),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultadosTestScreen(
                      respuestas: respuestas,
                    ),
                  ),
                );
              },
              child: Text('Enviar Respuestas'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPregunta(String texto, String key) {
    return ListTile(
      title: Text(texto),
      trailing: DropdownButton<int>(
        value: respuestas[key],
        onChanged: (value) {
          setState(() {
            respuestas[key] = value ?? 0;
          });
        },
        items: List.generate(
          10,
          (index) => DropdownMenuItem(
            value: index + 1,
            child: Text((index + 1).toString()),
          ),
        ),
      ),
    );
  }
}
