import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:conoce_bonao/constants/fees.dart';

class RestaurantReservationDetail {
  String restaurantId;
  int amountPeople;
  TimeOfDay arrivalTime;
  RestaurantReservationDetail({
    this.restaurantId = "",
    this.amountPeople = 1,
    required this.arrivalTime,
  });

  RestaurantReservationDetail copyWith({
    String? restaurantId,
    int? amountPeople,
    TimeOfDay? arrivalTime,
    double? total,
  }) {
    return RestaurantReservationDetail(
      restaurantId: restaurantId ?? this.restaurantId,
      amountPeople: amountPeople ?? this.amountPeople,
      arrivalTime: arrivalTime ?? this.arrivalTime,
    );
  }

  double get total {
    return amountPeople * FeeReservation.restaurantFeeReservation;
  }

  Map<String, dynamic> toMap() {
    final now = DateTime.now();
    final newDate = DateTime(
      now.year,
      now.month,
      now.day,
      arrivalTime.hour,
      arrivalTime.minute,
    );
    return <String, dynamic>{
      'restaurantId': restaurantId,
      'amountPeople': amountPeople,
      'arrivalTime': newDate.millisecondsSinceEpoch,
    };
  }

  factory RestaurantReservationDetail.fromMap(Map<String, dynamic> map) {
    return RestaurantReservationDetail(
      restaurantId: map['restaurantId'] as String,
      amountPeople: map['amountPeople'] as int,
      arrivalTime: TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(map['arrivalTime'] as int)),
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantReservationDetail.fromJson(String source) =>
      RestaurantReservationDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}
