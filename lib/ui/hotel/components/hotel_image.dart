import 'package:flutter/material.dart';
import 'package:conoce_bonao/models/hotel.dart';
import 'package:conoce_bonao/widgets/buttons/custom_back_button.dart';

import '../../../widgets/rounded_card_image.dart';

class HotelImage extends StatelessWidget {
  final HotelModel hotel;

  const HotelImage({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(43),
      bottomRight: Radius.circular(43),
    );
    return Stack(
      children: [
        Hero(
          tag: hotel.name,
          child: RoundedCardImage(
            image: hotel.image,
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
