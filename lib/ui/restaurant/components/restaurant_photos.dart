import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/widgets/photo_viewer.dart';
import 'package:conoce_bonao/widgets/rounded_card_image.dart';

import '../../../models/restaurant.dart';

class RestaurantPhotos extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantPhotos({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("Platos típicos"),
            Text("1/5"),
          ],
        ),
        const SizedBox(height: 5),
        Expanded(
          child: ListView.builder(
            itemCount: restaurant.photos.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) {
              final photo = restaurant.photos[index];
              return Container(
                margin: const EdgeInsets.only(
                  right: 10,
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(PhotoGalleryViewer(images: restaurant.photos, initialIndex: index));
                  },
                  child: RoundedCardImage(
                    image: photo,
                    borderRadius: BorderRadius.circular(20),
                    size: const Size(
                      70,
                      48,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
