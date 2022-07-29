import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationModel {
  double latitude;
  double longitude;

  LocationModel(this.latitude, this.longitude);

  factory LocationModel.unknow() => LocationModel(0, 0);
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory LocationModel.fromMap(map) {
    return LocationModel(
      map['latitude'] as double,
      map['longitude'] as double,
    );
  }
  LatLng toLatLng() => LatLng(latitude, longitude);
}
