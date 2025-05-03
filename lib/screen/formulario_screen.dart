import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/background_location_service.dart';
import 'seguimiento_screen.dart';

class FormularioScreen extends StatefulWidget {
  final String userId;
  const FormularioScreen({super.key, required this.userId});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();
  String sot = '';
  String cliente = '';
  String tipo = '';
  double lat = 0;
  double lon = 0;

  @override
  void initState() {
    super.initState();
    _getUbicacionActual();
  }

  Future<void> _getUbicacionActual() async {
    final pos = await Geolocator.getCurrentPosition();
    setState(() {
      lat = pos.latitude;
      lon = pos.longitude;
    });
  }

  void _iniciar() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final doc = await FirebaseFirestore.instance.collection('registros').add({
        'user_id': widget.userId,
        'sot': sot,
        'cliente': cliente,
        'tipo': tipo,
        'latitud': lat,
        'longitud': lon,
        'timestamp': FieldValue.serverTimestamp(),
      });

      await BackgroundLocationService().startTracking(docId: doc.id, uid: widget.userId);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SeguimientoScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulario')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'SOT'),
              onSaved: (val) => sot = val!,
              validator: (val) => val!.isEmpty ? 'Requerido' : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'CLIENTE'),
              onSaved: (val) => cliente = val!,
              validator: (val) => val!.isEmpty ? 'Requerido' : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'TIPO'),
              onSaved: (val) => tipo = val!,
              validator: (val) => val!.isEmpty ? 'Requerido' : null,
            ),
            const SizedBox(height: 20),
            Text('Latitud: $lat'),
            Text('Longitud: $lon'),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _iniciar, child: Text('Iniciar'))
          ]),
        ),
      ),
    );
  }
}
