import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/reservation_controller.dart';

abstract class BaseStep<Type extends StatefulWidget> extends State<Type> {
  final controller = Get.find<ReservationController>();
}
