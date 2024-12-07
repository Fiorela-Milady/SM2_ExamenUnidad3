import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:recomendacion_mov/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dashboard.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Función para realizar el login
  Future<void> _login() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    // Usar el AuthService para realizar el login
    bool success = await AuthService.login(
      email: email,
      password: password,
    );

    if (success) {
      // Si el login es exitoso, redirigimos al Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } else {
      // Si el login falla, mostramos un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Credenciales incorrectas'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Iniciar Sesión',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Correo',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _login,
                child: Text('Iniciar Sesión'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
