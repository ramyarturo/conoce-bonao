import 'package:flutter/material.dart';
import 'package:conoce_bonao/ui/hotel/hotel_detail_page.dart';
import 'package:conoce_bonao/utils/theme/colors.dart';

import 'animated_number.dart';

class RatingWidget extends StatelessWidget {
  final double rating;

  const RatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 44,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: greenColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: AnimatedNumber(
              number: rating,
              color: Colors.white,
            ),
          ),
        ),
        const Icon(Icons.star, color: yellowColor),
      ],
    );
  }
}
