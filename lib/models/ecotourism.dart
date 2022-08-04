// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'location.dart';

class Ecotourism {
  String image;
  LocationModel location;
  Ecotourism({
    required this.image,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'location': location.toMap(),
    };
  }

  factory Ecotourism.fromMap(Map<String, dynamic> map) {
    return Ecotourism(
      image: map['image'] as String,
      location: LocationModel.fromMap(map['location'] as Map<String, dynamic>),
    );
  }
}
