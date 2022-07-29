import 'dart:convert';

 import 'package:conoce_bonao/models/restaurant_reservation.dart';

import 'credit_card.dart';
import 'hotel_reservation.dart';

class ReservationRequest {
  HotelReservationDetail? hotelReservationDetail;
  RestaurantReservationDetail? restaurantReservationDetail;
  CreditCard creditCard;
  String userId;
  ReservationRequest({
    this.hotelReservationDetail,
    this.restaurantReservationDetail,
    required this.creditCard,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hotelReservationDetail': hotelReservationDetail?.toMap(),
      'restaurantReservationDetail': restaurantReservationDetail?.toMap(),
      'creditCard': creditCard.toMap(),
      'userId': userId,
    };
  }

  factory ReservationRequest.fromMap(Map<String, dynamic> map) {
    return ReservationRequest(
      hotelReservationDetail: map['hotelReservationDetail'] != null
          ? HotelReservationDetail.fromMap(map['hotelReservationDetail'] as Map<String, dynamic>)
          : null,
      restaurantReservationDetail: map['restaurantReservationDetail'] != null
          ? RestaurantReservationDetail.fromMap(map['restaurantReservationDetail'] as Map<String, dynamic>)
          : null,
      creditCard: CreditCard.fromMap(map['creditCard'] as Map<String, dynamic>),
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReservationRequest.fromJson(String source) => ReservationRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
