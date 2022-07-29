import 'package:location/location.dart';

import '../../core/exceptions.dart';

class LocationHelper {
  static final Location _location = Location.instance;

  static Future<LocationData> getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        throw RequestLocationServiceException("Servicio de ubicación deshabilitado");
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw DeniedLocationPermissionExcetion("Permiso denegado");
      }
    }

    return _location.getLocation();
  }
}
