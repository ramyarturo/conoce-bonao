
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ItemRatingBar extends StatelessWidget {
  final double rating;

  const ItemRatingBar({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width;
    return IgnorePointer(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(rating.toString()),
          RatingBar.builder(
            initialRating: rating,
            minRating: 1,
            itemSize: 20,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Theme.of(context).colorScheme.primary,
            ),
            onRatingUpdate: (_) {},
          ),
        ],
      ),
    );
  }
}
