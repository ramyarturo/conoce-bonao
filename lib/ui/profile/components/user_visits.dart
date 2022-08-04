
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../constants/controllers.dart';
import '../../../controllers/user_controller.dart';
import '../../../widgets/animated_number.dart';
import '../../../widgets/rx_value_listeneable.dart';
import '../../../widgets/shimmer_loading_widget.dart';

class UserVisits extends StatelessWidget {
  const UserVisits({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RxValueListeneableBuilder<UserReservation>(
            value: userController.userReservations,
            onLoading: const ContainerLoadingPlaceholder(
              size: Size.square(30),
            ),
            builder: (context, value) {
              return AnimatedNumber(
                number: value.totalReservations,
                builder: (number) {
                  return AutoSizeText(
                    number.toStringAsFixed(0),
                    maxFontSize: 20,
                    style: Theme.of(context).textTheme.headlineSmall,
                  );
                },
              );
            }),
        const Text("Visitas")
      ],
    );
  }
}