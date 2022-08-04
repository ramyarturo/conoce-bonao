import 'dart:convert';

import 'package:conoce_bonao/models/restaurant_reservation.dart';

import 'credit_card.dart';
import 'hotel_reservation.dart';

class ReservationRequest {
  HotelReservationDetail? hotelReservationDetail;
  RestaurantReservationDetail? restaurantReservationDetail;
  CreditCard creditCard;
  String userId;
  String state;
  String id;
  ReservationRequest({
    this.hotelReservationDetail,
    this.restaurantReservationDetail,
    required this.creditCard,
    required this.userId,
    this.state = 'Reservado',
    this.id = "",
  });

  double get totalAmount {
    return hotelReservationDetail?.total ?? restaurantReservationDetail!.total;
  }
 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hotelReservationDetail': hotelReservationDetail?.toMap(),
      'restaurantReservationDetail': restaurantReservationDetail?.toMap(),
      'creditCard': creditCard.toMap(),
      'userId': userId,
      'state': state,
      'id': id,
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
      state: map['state'] ?? 'Reservado',
      id: map['id'] ?? '0',
    );
  }
}
