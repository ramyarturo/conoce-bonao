// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'location.dart';

class Ecotourism {
  String image;
  String description;

  String address;
  LocationModel location;
  Ecotourism({
    required this.image,
    required this.description,
    required this.address,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'description': description,
      'address': address,
      'location': location.toMap(),
    };
  }

  factory Ecotourism.fromMap(Map<String, dynamic> map) {
    return Ecotourism(
      image: map['image'],
      description: map['description'],
      address: map['address'],
      location: LocationModel.fromMap(map['location'] as Map<String, dynamic>),
    );
  }
}
