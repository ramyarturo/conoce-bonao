import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/constants/controllers.dart';
 import 'package:conoce_bonao/models/reservation.dart';
import 'package:conoce_bonao/models/restaurant_reservation.dart';
import 'package:conoce_bonao/ui/home/home_page.dart';
import 'package:conoce_bonao/ui/reservation/reservation_page.dart';
import 'package:conoce_bonao/ui/reservation/steps/base_step.dart';
import 'package:conoce_bonao/widgets/loading_widget.dart';

import '../constants/repositories.dart';
import '../models/credit_card.dart';
import '../models/hotel_reservation.dart';
import '../ui/reservation/steps/confirm_step.dart';
import '../ui/reservation/steps/detail_step.dart';
import '../ui/reservation/steps/payment_step.dart';

class ReservationController extends GetxController {
  var currentStep = 0;
  var stepState = RxMap.of(List.filled(3, false).asMap())..[0] = true;
  bool get isLastStep => currentStep == 2;
  final creditCard = CreditCard().obs;
  late ReservationDetails reservationDetails;
  late final hotelReservation = HotelReservationDetail(
    hotelId: reservationDetails.hotel?.id ?? "",
    date: DateTime.now(),
  ).obs;
  late final restaurantReservation = RestaurantReservationDetail(
    restaurantId: reservationDetails.restaurant?.id ?? "",
    arrivalTime: TimeOfDay.now(),
  ).obs;

  final stepKeys = List<GlobalKey>.generate(3, (_) => GlobalKey());
  late final steps = {
    "Detalles": () => DetailStep(key: stepKeys[0]),
    "Pagos": () => PaymentStep(key: stepKeys[1]),
    "Confirmación": () => ConfirmStep(key: stepKeys[2]),
  };

  onStepContinue() async {
    final currentStepState = stepKeys[currentStep].currentState;
    if (currentStepState is BaseStep) {
      if (!await currentStepState.validate()) {
        return;
      }
    }
    if (!isLastStep) {
      if (currentStep == 1) {
        stepState[2] = true;
      }

      stepState[++currentStep] = true;
      refresh();
    } else {
      _performReservation();
    }
  }

  _performReservation() async {
    showLoading();
    final request = ReservationRequest(
      creditCard: creditCard.value,
      userId: authController.firebaseUser.value!.uid,
      hotelReservationDetail: reservationDetails.isHotelReservation ? hotelReservation.value : null,
      restaurantReservationDetail: !reservationDetails.isHotelReservation ? restaurantReservation.value : null,
    );
    await reservationRepository.createReservation(request);
    Get.offAll(const HomePage());
  }
}
