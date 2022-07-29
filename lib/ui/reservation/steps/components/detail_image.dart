import 'package:flutter/material.dart';
import 'package:conoce_bonao/widgets/rounded_card_image.dart';

class DetailImage extends StatelessWidget {
  final String imagePath;

  const DetailImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return RoundedCardImage(
      size: const Size.fromHeight(200),
      image: imagePath,
    );
  }
}
