import 'package:permission_handler/permission_handler.dart';

Future<void> solicitarPermisosUbicacion() async {
  await Permission.location.request();
  await Permission.locationAlways.request();
}
