import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/widgets/rounded_card_image.dart';

import '../../../models/hotel.dart';
import '../../../widgets/photo_viewer.dart';

class HotelPhotos extends StatelessWidget {
  final HotelModel hotel;

  const HotelPhotos({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Fotos"),
            Text("5/8"),
          ],
        ),
        const SizedBox(height: 5),
        Expanded(
          child: ListView.builder(
            itemCount: hotel.photos.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) {
              final photo = hotel.photos[index];
              return Container(
                margin: const EdgeInsets.only(
                  right: 10,
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(PhotoGalleryViewer(images: hotel.photos, initialIndex: index));
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
