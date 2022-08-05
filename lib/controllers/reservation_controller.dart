import 'package:conoce_bonao/constants/theme.dart';
import 'package:conoce_bonao/core/dialogs/reservation_balance_not_available.dart';
import 'package:conoce_bonao/core/result.dart';
import 'package:conoce_bonao/core/status.dart';
import 'package:conoce_bonao/ui/profile/add_balance_page.dart';
import 'package:conoce_bonao/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/constants/controllers.dart';
import 'package:conoce_bonao/models/reservation.dart';
import 'package:conoce_bonao/models/restaurant_reservation.dart';
import 'package:conoce_bonao/ui/home/home_page.dart';
import 'package:conoce_bonao/ui/reservation/reservation_page.dart';
import 'package:conoce_bonao/ui/reservation/steps/base_step.dart';

import '../constants/repositories.dart';
import '../models/credit_card.dart';
import '../models/hotel_reservation.dart';
import '../models/notification.dart';
import '../ui/reservation/steps/confirm_step.dart';
import '../ui/reservation/steps/detail_step.dart';
import '../ui/reservation/steps/payment_step.dart';

class ReservationController extends GetxController {
  var currentStep = 0;
  var stepState = RxMap.of(List.filled(3, false).asMap())..[0] = true;
  bool get isLastStep => currentStep == 2;
  late ReservationDetails reservationDetails;
  ReservationRequest get request => ReservationRequest(
        userId: authController.firebaseUser.value!.uid,
        hotelReservationDetail: reservationDetails.isHotelReservation ? hotelReservation.value : null,
        restaurantReservationDetail: !reservationDetails.isHotelReservation ? restaurantReservation.value : null,
      );
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
    final currentKey = stepKeys[currentStep];
    final currentStepWidget = currentKey.currentWidget;

    if (currentStepWidget is DetailStep) {
      currentStep++;
      refresh();
    }
    if (currentStepWidget is PaymentStep) {
      _performReservation();
    }
    if (currentStepWidget is ConfirmStep) {
      Get.offAll(const HomePage());
    }
  }

  bool _hasBalanceAvailable() {
    final userBalance = userController.currentUser.value!.balance;

    return userBalance >= request.totalAmount;
  }

  _performReservation() async {
    if (!_hasBalanceAvailable()) {
      Get.bottomSheet(ReservationBalanceNotAvailableMessage(
        totalAmount: request.totalAmount,
        chargeNow: () async {
          final result = await Get.to(const AddBalancePage());
          if (result == Result.ok) {
            Get.back();
            _performReservation();
          }
        },
      ));
      return;
    }
    Get.to(const _ProcessingPaymentMessage());
    await Future.delayed(2.seconds);
    await reservationRepository.createReservation(request);
    userController.updateUserBalance(-request.totalAmount);
    Get.back();
    notificationController.onNewNotification(NotificationModel(
      id: 0,
      title: "Reservacíon realizada",
      body: "Su reservación a sido registrada, Gracias!",
      sentAt: DateTime.now(),
    ));
    stepState[currentStep] = true;
    stepState[++currentStep] = true;
    refresh();
  }
}

class _ProcessingPaymentMessage extends StatelessWidget {
  const _ProcessingPaymentMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const VerticalSpacing(),
          Text("Procesando Pago...", style: Get.textTheme.labelMedium),
        ],
      )),
    );
  }
}
