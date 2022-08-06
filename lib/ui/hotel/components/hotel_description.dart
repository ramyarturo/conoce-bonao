import 'package:flutter/material.dart';
import 'package:conoce_bonao/models/hotel.dart';
import 'package:readmore/readmore.dart';

import '../../../utils/theme/colors.dart';

class HotelDescription extends StatelessWidget {
  const HotelDescription({super.key, required this.hotel});
  final HotelModel hotel;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hotel.name,
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
                hotel.address,
                style: theme.textTheme.labelSmall,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        ReadMoreText(
          hotel.description,
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
