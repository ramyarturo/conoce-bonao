import 'package:conoce_bonao/models/ecotourism.dart';
import 'package:flutter/material.dart';
import 'package:conoce_bonao/widgets/rounded_card_image.dart';

import '../../../widgets/buttons/custom_back_button.dart';

class EcotourismImage extends StatelessWidget {
  final Ecotourism ecotourism;

  const EcotourismImage({super.key, required this.ecotourism});

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(43),
      bottomRight: Radius.circular(43),
    );
    return Stack(
      children: [
        Hero(
          tag: ecotourism.image,
          child: RoundedCardImage(
            image: ecotourism.image,
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
