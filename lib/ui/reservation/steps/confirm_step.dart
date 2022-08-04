import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/theme.dart';
import '../../../controllers/reservation_controller.dart';
import '../../../utils/theme/colors.dart';

class ConfirmStep extends StatelessWidget {
  ConfirmStep({Key? key}) : super(key: key);
  final controller = Get.find<ReservationController>();

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              color: greenLightColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: greyColor,
                width: 3,
              )),
          child: const Icon(
            Icons.done,
            color: Colors.white,
            size: 100,
          ),
        ),
        const VerticalSpacing(30),
        Text(
          "Pago realizado!",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const VerticalSpacing(10),
        const Text(
          "Su pago ha sido procesado con exito, a continuacion recibira informacion sobre su reservacion en su correo electronico.",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
