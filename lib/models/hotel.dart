import 'dart:convert';

import 'package:conoce_bonao/models/location.dart';

class HotelModel {
  String id;
  String name;
  String address;
  String description;
  String image;
  List<String> photos;
  int temperature;
  double rating;
  int visitors;
  LocationModel location;
  HotelModel({
    this.id = "",
    required this.name,
    required this.address,
    required this.description,
    required this.image,
    required this.photos,
    required this.temperature,
    required this.rating,
    required this.visitors,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'description': description,
      'image': image,
      'photos': photos,
      'temperature': temperature,
      'rating': rating,
      'visitors': visitors,
      'location': location.toMap(),
    };
  }

  factory HotelModel.fromMap(Map<String, dynamic> map) {
    return HotelModel(
      name: map['name'] as String,
      address: map['address'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      photos: List<String>.from(map['photos']),
      temperature: map['temperature'] as int,
      rating: map['rating'] as double,
      visitors: map['visitors'] as int,
      location: LocationModel.fromMap(map['location']),
    );
  }

  String toJson() => json.encode(toMap());

  HotelModel copyWith({
    String? id,
    String? name,
    String? address,
    String? description,
    String? image,
    List<String>? photos,
    int? temperature,
    double? rating,
    int? visitors,
    LocationModel? location,
  }) {
    return HotelModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      description: description ?? this.description,
      image: image ?? this.image,
      photos: photos ?? this.photos,
      temperature: temperature ?? this.temperature,
      rating: rating ?? this.rating,
      visitors: visitors ?? this.visitors,
      location: location ?? this.location,
    );
  }

  factory HotelModel.fromJson(String source) => HotelModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
