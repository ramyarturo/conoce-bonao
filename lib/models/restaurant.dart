import 'dart:convert';

import 'package:conoce_bonao/models/location.dart';

class RestaurantModel {
  String id;
  String name;
  String title;
  String address;
  String description;
  double rating;
  String image;
  List<String> photos;
  LocationModel location;
  RestaurantModel({
    this.id = "",
    required this.name,
    required this.title,
    required this.address,
    required this.description,
    required this.rating,
    required this.image,
    required this.photos,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'title': title,
      'address': address,
      'description': description,
      'rating': rating,
      'image': image,
      'photos': photos,
      'location': location.toMap(),
    };
  }

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      name: map['name'] as String,
      title: map['title'] as String,
      address: map['address'] as String,
      description: map['description'] as String,
      rating: map['rating'] as double,
      image: map['image'] as String,
      photos: List<String>.from(map['photos']),
      location: LocationModel.fromMap(map['location']),
    );
  }

  String toJson() => json.encode(toMap());

  RestaurantModel copyWith({
    String? id,
    String? name,
    String? title,
    String? address,
    String? description,
    double? rating,
    String? image,
    List<String>? photos,
    LocationModel? location,
  }) {
    return RestaurantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      address: address ?? this.address,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      image: image ?? this.image,
      photos: photos ?? this.photos,
      location: location ?? this.location,
    );
  }

  factory RestaurantModel.fromJson(String source) => RestaurantModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
