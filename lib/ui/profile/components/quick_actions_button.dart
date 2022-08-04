
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/theme.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../../home/home_page.dart';
import '../myreservations/my_reservations_page.dart';

class QuickActionsButton extends StatelessWidget {
  const QuickActionsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Acciones Rápidas",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const VerticalSpacing(),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                text: "Notificaciones",
                icon: Icons.notifications,
                outlined: true,
                padding: const EdgeInsets.all(10),
                borderRadius: 15,
                onPressed: () {
                  context.findAncestorStateOfType<HomePageState>()?.changeBottomNavIndex(2);
                },
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: CustomButton(
                text: "Reservaciones",
                icon: Icons.calendar_month,
                outlined: true,
                padding: const EdgeInsets.all(10),
                borderRadius: 15,
                onPressed: () {
                  Get.to(MyReservationsPage());
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
