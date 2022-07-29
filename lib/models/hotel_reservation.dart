import 'dart:convert';

import '../constants/fees.dart';

class HotelReservationDetail {
  String hotelId;
  int amountPeople;
  int amountNight;
  DateTime date;

  HotelReservationDetail({
    this.hotelId = "",
    this.amountPeople = 1,
    this.amountNight = 1,
    required this.date,
  });

  HotelReservationDetail copyWith({
    String? hotelId,
    int? amountPeople,
    int? amountNight,
    DateTime? date,
  }) {
    return HotelReservationDetail(
      hotelId: hotelId ?? this.hotelId,
      amountPeople: amountPeople ?? this.amountPeople,
      amountNight: amountNight ?? this.amountNight,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hotelId': hotelId,
      'amountPeople': amountPeople,
      'amountNight': amountNight,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory HotelReservationDetail.fromMap(Map<String, dynamic> map) {
    return HotelReservationDetail(
      hotelId: map['hotelId'] as String,
      amountPeople: map['amountPeople'] as int,
      amountNight: map['amountNight'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }
  factory HotelReservationDetail.fromJson(String source) => HotelReservationDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  double get total {
    final totalPriceByNight = amountNight * FeeReservation.hotelPriceByNight;
    return amountPeople * totalPriceByNight + FeeReservation.hotelTaxes;
  }
}
