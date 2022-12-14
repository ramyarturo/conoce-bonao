import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../models/restaurant.dart';
import '../../../utils/theme/colors.dart';

class RestaurantDescription extends StatelessWidget {
  const RestaurantDescription({super.key, required this.restaurant});
  final RestaurantModel restaurant;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Restaurante ${restaurant.name}",
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: greenColor,
            ),
            Expanded(
              child: Text(
                restaurant.address,
                style: theme.textTheme.labelSmall,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        ReadMoreText(
          restaurant.description,
          style: theme.textTheme.bodyLarge,
          trimLines: 15,
          colorClickableText: greenDarkerColor,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'ver mas...',
          trimExpandedText: 'ver menos',
          moreStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: greenDarkerColor,
          ),
        ),
      ],
    );
  }
}
