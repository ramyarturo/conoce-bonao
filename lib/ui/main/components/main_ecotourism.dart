import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/constants/controllers.dart';
import 'package:conoce_bonao/widgets/rounded_card_image.dart';
import 'package:conoce_bonao/widgets/rx_value_listeneable.dart';
import 'package:conoce_bonao/widgets/shimmer_loading_widget.dart';

import '../../../widgets/photo_viewer.dart';

class HomeEcotourism extends StatelessWidget {
  const HomeEcotourism({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Ecoturismo",
          style: Theme.of(context).textTheme.headline6,
        ),
        RxValueListeneableBuilder<List<String>>(
          value: mainController.ecotourismList,
          onLoading: const _EcotourismLoadingShimmer(),
          builder: (context, data) {
            if (data.isEmpty) {
              return const Center(
                child: Text("No existen ecoturismos registrados"),
              );
            }
            data.shuffle();
            final images = data.take(6).toList();

            return GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (var index = 0; index < images.length; index++)
                    GestureDetector(
                      onTap: () {
                        Get.to(PhotoGalleryViewer(
                          images: images,
                          initialIndex: index,
                        ));
                      },
                      child: _EcotourismItem(
                        index: index,
                        image: images[index],
                      ),
                    )
                ]);
          },
        ),
      ],
    );
  }
}

class _EcotourismItem extends StatelessWidget {
  const _EcotourismItem({
    Key? key,
    required this.index,
    required this.image,
  }) : super(key: key);

  final int index;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(75),
          gradient: LinearGradient(
            begin: index % 2 == 0 ? Alignment.bottomCenter : Alignment.topCenter,
            colors: const [
              Color(0xffFBA83C),
              Color(0xff0A8791),
            ],
          ),
          border: Border.all(
            color: Colors.transparent,
            width: 4,
          )),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(75),
        child: RoundedCardImage(image: image),
      ),
    );
  }
}

class _EcotourismLoadingShimmer extends StatelessWidget {
  const _EcotourismLoadingShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1.6,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        6,
        (index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(75),
            child: const ContainerLoadingPlaceholder(size: Size.square(75)),
          );
        },
      ),
    );
  }
}
