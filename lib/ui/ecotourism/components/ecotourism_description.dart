import 'package:conoce_bonao/models/ecotourism.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../utils/theme/colors.dart';

class EcotourismDescription extends StatelessWidget {
  const EcotourismDescription({super.key, required this.ecotourism});
  final Ecotourism ecotourism;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: greenColor,
            ),
            Text(
              ecotourism.address,
              style: theme.textTheme.labelSmall,
            ),
          ],
        ),
        const SizedBox(height: 15),
        ReadMoreText(
          ecotourism.description,
          style: theme.textTheme.bodyLarge,
          trimLines: 2,
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
