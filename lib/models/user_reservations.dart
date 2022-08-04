import 'dart:convert';

class UserReservations {
  String userId;
  List<String> hotels;
  List<String> restaurants;
  UserReservations({
    required this.userId,
    required this.hotels,
    required this.restaurants,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'hotels': hotels,
      'restaurants': restaurants,
    };
  }

  factory UserReservations.fromMap(Map<String, dynamic> map) {
    return UserReservations(
      userId: map['userId'] as String,
      hotels: map['hotels']?.cast<String>() ?? [],
      restaurants: map['restaurants']?.cast<String>() ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserReservations.fromJson(String source) => UserReservations.fromMap(json.decode(source) as Map<String, dynamic>);
}
