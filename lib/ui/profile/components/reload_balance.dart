
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/controllers.dart';
import '../../../utils/theme/colors.dart';
import '../add_balance_page.dart';

class ReloadBalance extends StatelessWidget {
  const ReloadBalance({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: const StadiumBorder(),
          ),
          onPressed: () {
            Get.to(AddBalancePage())?.then((value) {
              if (value is double) {
                userController.updateUserBalance(value);
              }
            });
          },
          child: const Text("Recargar Saldo"),
        ),
        const SizedBox(width: 15),
        for (var i = 0; i < 3; i++)
          Container(
            height: 10,
            width: 10,
            margin: const EdgeInsets.only(
              right: 5,
            ),
            decoration: const BoxDecoration(
              color: orangeColor,
              shape: BoxShape.circle,
            ),
          )
      ],
    );
  }
}