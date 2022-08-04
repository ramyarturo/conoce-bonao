import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/controllers.dart';
import '../../constants/theme.dart';
import '../../ui/home/home_page.dart';
import '../../utils/format_utils.dart';
import '../../utils/theme/colors.dart';
import '../../widgets/buttons/custom_button.dart';

class ReservationBalanceNotAvailableMessage extends StatelessWidget {
  final VoidCallback chargeNow;
  final double totalAmount;

  const ReservationBalanceNotAvailableMessage({super.key, required this.chargeNow, required this.totalAmount,});
  @override
  Widget build(BuildContext context) {
    final difference = totalAmount - userController.currentUser.value!.balance;
    final hasBalance = userController.currentUser.value!.balance > 0;
    final chargeBalance = hasBalance ? " ${FormatUtils.formatCurrency(difference)}" : "";
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(defaultPadding),
      constraints: BoxConstraints(
        maxHeight: Get.mediaQuery.size.height * 0.4,
      ),
      child: Column(
        children: [
          Text(
            "No cuentas con saldo ${hasBalance ? "suficiente" : "disponible"} \n (recargar$chargeBalance)",
            textAlign: TextAlign.center,
            style: Get.textTheme.labelSmall!.copyWith(
              color: greenColor,
            ),
          ),
          const VerticalSpacing(),
          const Divider(thickness: 2),
          const Text(
            "Actualmente tu tarjeta no cuenta con fondos para realizar esta reservacion, recarga tu saldo e intenta nuevamente",
          ),
          const Divider(thickness: 2),
          const Spacer(),
          CustomButton(
            text: "Recargar Ahora",
            secundary: true,
            onPressed: chargeNow,
          ),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              text: "Cancelar",
              outlined: true,
              onPressed: () => Get.offAll(const HomePage()),
            ),
          )
        ],
      ),
    );
  }
}
