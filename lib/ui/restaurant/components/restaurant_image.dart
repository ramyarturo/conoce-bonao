import 'package:flutter/material.dart';
import 'package:conoce_bonao/models/restaurant.dart';
import 'package:conoce_bonao/widgets/rounded_card_image.dart';

import '../../../gen/assets.gen.dart';
import '../../../widgets/custom_back_button.dart';

class RestaurantImage extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantImage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(43),
      bottomRight: Radius.circular(43),
    );
    return Stack(
      children: [
        Hero(
          tag: restaurant.name,
          child: RoundedCardImage(
            image: restaurant.image,
            borderRadius: borderRadius,
            size: const Size.fromHeight(250),
          ),
        ),
        Padding(
          padding: MediaQuery.of(context).viewPadding,
          child: const Align(
            alignment: Alignment.topLeft,
            child: CustomBackButton(),
          ),
        )
      ],
    );
  }
}
