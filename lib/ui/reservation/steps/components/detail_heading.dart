import 'package:flutter/material.dart';

import '../../../../widgets/rating_widget.dart';

class DetailHeading extends StatelessWidget {
  final String title;
  final String subtitle;
  final double rating;

  const DetailHeading({
    super.key,
    required this.title,
    required this.subtitle,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline4,
            ),
            RatingWidget(rating: rating),
          ],
        ),
        const Text("Reservar"),
      ],
    );
  }
}
