import 'package:flutter/material.dart';
import 'package:conoce_bonao/constants/theme.dart';
import 'package:conoce_bonao/ui/map/components/building_item_rating_bar.dart';

import '../../../widgets/rounded_card_image.dart';

class BuildingInfo {
  String title;
  String subtitle;
  String address;
  String image;
  double rating;
  List<String> photos;
  BuildingInfo({
    required this.title,
    required this.subtitle,
    required this.address,
    required this.image,
    required this.rating,
    required this.photos,
  });
}

class BuildingItemCard extends StatelessWidget {
  const BuildingItemCard({
    Key? key,
    required this.buildingInfo,
    this.onPressed,
  }) : super(key: key);

  final BuildingInfo buildingInfo;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      buildingInfo.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Visibility(
                      visible: buildingInfo.subtitle.isNotEmpty,
                      child: Text(buildingInfo.subtitle),
                    ),
                    ItemRatingBar(rating: buildingInfo.rating),
                    Text(buildingInfo.address),
                    OutlinedButton(
                      onPressed: onPressed,
                      child: const Text("Llegar"),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              RoundedCardImage(
                image: buildingInfo.image,
                size: const Size.square(60),
              ),
            ],
          ),
        ));
  }
}
