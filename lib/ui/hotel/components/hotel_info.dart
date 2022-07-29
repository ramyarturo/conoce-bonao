import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../models/hotel.dart';
import '../../../widgets/animated_number.dart';
import '../../../widgets/rating_widget.dart';

class HotelInfo extends StatelessWidget {
  const HotelInfo({super.key, required this.hotel});

  final HotelModel hotel;

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            const Text("Temperatura"),
            const Text("Rating"),
            Row(
              children: [
                AnimatedNumber(
                  number: hotel.visitors,
                ),
                const SizedBox(width: 4),
                const Text("visitantes"),
              ],
            )
          ],
        ),
        TableRow(
          children: [
            Row(
              children: [
                Assets.icons.temperature.image(),
                AnimatedNumber(number: hotel.temperature),
              ],
            ),
            RatingWidget(
              rating: hotel.rating,
            ),
            Assets.images.hotels.visitors.image()
          ],
        ),
      ],
    );
  }
}
