import 'package:flutter/material.dart';

class SeguimientoScreen extends StatelessWidget {
  const SeguimientoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rastreo activo')),
      body: const Center(child: Text('Tu ubicación está siendo rastreada...')),
    );
  }
}
