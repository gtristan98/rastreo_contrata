import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/settings/locator_settings.dart';
import 'package:background_locator_2/settings/android_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:flutter/material.dart';

import 'location_callback_handler.dart';

class BackgroundLocationService {
  static double? _lastLat;
  static double? _lastLong;
  static String? _docId;
  static String? _userId;

  Future<void> startTracking({required String docId, required String uid}) async {
    _docId = docId;
    _userId = uid;

    await BackgroundLocator.initialize();
    BackgroundLocator.registerLocationUpdate(
      LocationCallbackHandler.callback,
      initCallback: LocationCallbackHandler.initCallback,
      initDataCallback: {'docId': docId, 'userId': uid},
      disposeCallback: LocationCallbackHandler.disposeCallback,
      autoStop: false,
      androidSettings: AndroidSettings(
        accuracy: LocationAccuracy.NAVIGATION,
        interval: 5,
        distanceFilter: 10,
        androidNotificationSettings: AndroidNotificationSettings(
          notificationChannelName: 'Location tracking',
          notificationTitle: 'Ubicación activa',
          notificationMsg: 'Rastreando en segundo plano',
          notificationBigMsg:
              'Esta app rastrea tu ubicación para funciones críticas, incluso cuando está cerrada.',
          notificationIconColor: Colors.grey,
          notificationTapCallback: LocationCallbackHandler.notificationCallback,
        ),
      ),
    );
  }

  static Future<void> updateFirestore(double lat, double long) async {
    if (_lastLat == null || _lastLong == null) {
      _lastLat = lat;
      _lastLong = long;
      return;
    }

    double distance = geo.Geolocator.distanceBetween(_lastLat!, _lastLong!, lat, long);
    if (distance >= 10 && _docId != null) {
      _lastLat = lat;
      _lastLong = long;

      await FirebaseFirestore.instance.collection('registros').doc(_docId!).update({
        'latitud': lat,
        'longitud': long,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }
}
