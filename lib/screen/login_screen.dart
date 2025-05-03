import 'package:flutter/material.dart';
import 'formulario_screen.dart';
import '../utils/permisos.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _login(BuildContext context) async {
    await solicitarPermisosUbicacion();
    const userId = 'user123'; // Simulado
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => FormularioScreen(userId: userId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () => _login(context), child: const Text('Iniciar sesión')),
      ),
    );
  }
}
