import 'package:cloud_firestore/cloud_firestore.dart';

class Registro {
  final String userId;
  final String sot;
  final String cliente;
  final String tipo;
  final double latitud;
  final double longitud;
  final DateTime timestamp;

  Registro({
    required this.userId,
    required this.sot,
    required this.cliente,
    required this.tipo,
    required this.latitud,
    required this.longitud,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'sot': sot,
      'cliente': cliente,
      'tipo': tipo,
      'latitud': latitud,
      'longitud': longitud,
      'timestamp': timestamp,
    };
  }

  factory Registro.fromMap(Map<String, dynamic> map) {
    return Registro(
      userId: map['user_id'],
      sot: map['sot'],
      cliente: map['cliente'],
      tipo: map['tipo'],
      latitud: map['latitud'],
      longitud: map['longitud'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}
