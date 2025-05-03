import 'package:background_locator_2/location_dto.dart';
import 'background_location_service.dart';

class LocationCallbackHandler {
  static Future<void> initCallback(Map<dynamic, dynamic> params) async {
    print('Init callback');
  }

  static Future<void> disposeCallback() async {
    print('Dispose callback');
  }

  static Future<void> callback(LocationDto locationDto) async {
    print('Ubicación: ${locationDto.latitude}, ${locationDto.longitude}');
    await BackgroundLocationService.updateFirestore(locationDto.latitude, locationDto.longitude);
  }

  static void notificationCallback() {
    print('Notificación presionada');
  }
}
