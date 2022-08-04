import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:conoce_bonao/controllers/reservation_controller.dart';
import 'package:conoce_bonao/models/hotel.dart';
import 'package:conoce_bonao/models/restaurant.dart';
import 'package:conoce_bonao/ui/reservation/components/reservation_stepper.dart';

import '../../widgets/buttons/custom_button.dart';

enum ReservationType { hotel, restaurant }

class ReservationDetails {
  final ReservationType reservationType;
  final RestaurantModel? restaurant;
  final HotelModel? hotel;

  ReservationDetails({required this.reservationType, this.restaurant, this.hotel});
  bool get isHotelReservation => reservationType == ReservationType.hotel;
}

class ReservationPage extends StatefulWidget {
  final ReservationType reservationType;
  final RestaurantModel? restaurant;
  final HotelModel? hotel;
  const ReservationPage({
    super.key,
    required this.reservationType,
    this.hotel,
    this.restaurant,
  });

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final reservationController = Get.put(ReservationController());

  @override
  void initState() {
    super.initState();
    reservationController.reservationDetails = ReservationDetails(
      reservationType: widget.reservationType,
      hotel: widget.hotel,
      restaurant: widget.restaurant,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: GetBuilder<ReservationController>(builder: (_) {
        return Column(
          children: [
            Flexible(
              child: ReservationStepper(),
            ),
            SizedBox(
              width: 300,
              child: CustomButton(
                text: reservationController.isLastStep ? "Listo!" : "Continuar",
                icon: Icons.arrow_forward,
                secundary: true,
                onPressed: reservationController.onStepContinue,
              ),
            )
          ],
        );
      }),
    );
  }
}
