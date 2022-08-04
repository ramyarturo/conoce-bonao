
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/controllers.dart';
import '../../../utils/format_utils.dart';
import '../../../widgets/animated_number.dart';

class UserBalance extends StatelessWidget {
  const UserBalance({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          return AnimatedNumber(
            number: userController.currentUser.value?.balance ?? 0,
            builder: (number) {
              return AutoSizeText(
                FormatUtils.formatCurrency(number, symbol: "\$"),
                maxFontSize: 20,
                style: Theme.of(context).textTheme.headlineSmall,
              );
            },
          );
        }),
        const Text("Saldo")
      ],
    );
  }
}